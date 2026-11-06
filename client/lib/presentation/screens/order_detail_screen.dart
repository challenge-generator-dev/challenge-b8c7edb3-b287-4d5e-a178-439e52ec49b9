package:pedidos_app.presentation.screens;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pedidos_app/presentation/blocs/order/order_bloc.dart';
import 'package:pedidos_app/presentation/blocs/order/order_event.dart';
import 'package:pedidos_app/presentation/blocs/order/order_state.dart';
import 'package:pedidos_app/domain/entities/order.dart';
import 'package:pedidos_app/domain/entities/order_item.dart';

class OrderDetailScreen extends StatefulWidget {
  final String orderId;

  const OrderDetailScreen({
    super.key,
    required this.orderId,
  });

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OrderBloc>().add(LoadOrderByIdEvent(widget.orderId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detalle del Pedido',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 2,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if (state is OrderLoading || state is OrderInitial) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text(
                    'Cargando detalles del pedido...',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is OrderError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red.shade400,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Error al cargar el pedido',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.red.shade700,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () {
                        context
                            .read<OrderBloc>()
                            .add(LoadOrderByIdEvent(widget.orderId));
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Reintentar'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is OrderDetailLoaded) {
            return _buildOrderDetail(context, state.order);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildOrderDetail(BuildContext context, Order order) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeaderSection(context, order),
          const SizedBox(height: 24),
          _buildStatusSection(context, order),
          const SizedBox(height: 24),
          _buildItemsSection(context, order),
          const SizedBox(height: 24),
          _buildSummarySection(context, order),
          const SizedBox(height: 24),
          _buildActionsSection(context, order),
        ],
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context, Order order) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Pedido #${order.id}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildStatusChip(order.status),
              ],
            ),
            const Divider(height: 24),
            _buildInfoRow(
              Icons.calendar_today,
              'Fecha de creación',
              _formatDateTime(order.createdAt),
            ),
            const SizedBox(height: 12),
            _buildInfoRow(
              Icons.access_time,
              'Última actualización',
              _formatDateTime(order.updatedAt),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusSection(BuildContext context, Order order) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Estado del Pedido',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildStatusTimeline(order.status),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusTimeline(String status) {
    final statuses = ['pending', 'processing', 'completed'];
    final currentIndex = statuses.indexOf(status.toLowerCase());

    return Row(
      children: List.generate(statuses.length * 2 - 1, (index) {
        if (index.isOdd) {
          final lineIndex = index ~/ 2;
          final isCompleted = lineIndex < currentIndex;
          return Expanded(
            child: Container(
              height: 2,
              color: isCompleted ? Colors.green : Colors.grey.shade300,
            ),
          );
        } else {
          final stepIndex = index ~/ 2;
          final isCompleted = stepIndex <= currentIndex;
          final isCurrent = stepIndex == currentIndex;

          return Column(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isCompleted ? Colors.green : Colors.grey.shade300,
                  border: isCurrent
                      ? Border.all(color: Colors.green, width: 2)
                      : null,
                ),
                child: Icon(
                  isCompleted ? Icons.check : Icons.circle,
                  size: 16,
                  color: isCompleted ? Colors.white : Colors.grey,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _getStatusLabel(statuses[stepIndex]),
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                  color: isCurrent ? Colors.green : Colors.grey,
                ),
              ),
            ],
          );
        }
      }),
    );
  }

  String _getStatusLabel(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return 'Pendiente';
      case 'processing':
        return 'Procesando';
      case 'completed':
        return 'Completado';
      default:
        return status;
    }
  }

  Widget _buildItemsSection(BuildContext context, Order order) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Productos',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${order.items.length} ${order.items.length == 1 ? 'item' : 'items'}',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...order.items.map((item) => _buildItemTile(item)),
          ],
        ),
      ),
    );
  }

  Widget _buildItemTile(OrderItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.shopping_bag,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.productName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Cantidad: ${item.quantity}',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '\$${(item.price * item.quantity).toStringAsFixed(2)}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummarySection(BuildContext context, Order order) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Resumen',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildSummaryRow('Subtotal', order.subtotal),
            const SizedBox(height: 8),
            _buildSummaryRow('Impuestos', order.tax),
            const SizedBox(height: 8),
            _buildSummaryRow('Envío', order.shippingCost),
            const Divider(height: 24),
            _buildSummaryRow(
              'Total',
              order.total,
              isTotal: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, double amount, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? Colors.black : Colors.grey.shade700,
          ),
        ),
        Text(
          '\$${amount.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: isTotal ? 18 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? Colors.green.shade700 : Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildActionsSection(BuildContext context, Order order) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (order.status.toLowerCase() == 'pending')
          ElevatedButton.icon(
            onPressed: () {
              context.read<OrderBloc>().add(CancelOrderEvent(order.id));
            },
            icon: const Icon(Icons.cancel_outlined),
            label: const Text('Cancelar Pedido'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade600,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.support_agent_outlined),
          label: const Text('Contactar Soporte'),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey.shade600),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatusChip(String status) {
    Color backgroundColor;
    Color textColor;

    switch (status.toLowerCase()) {
      case 'completed':
      case 'completado':
        backgroundColor = Colors.green.shade100;
        textColor = Colors.green.shade800;
        break;
      case 'pending':
      case 'pendiente':
        backgroundColor = Colors.orange.shade100;
        textColor = Colors.orange.shade800;
        break;
      case 'cancelled':
      case 'cancelado':
        backgroundColor = Colors.red.shade100;
        textColor = Colors.red.shade800;
        break;
      case 'processing':
      case 'procesando':
        backgroundColor = Colors.blue.shade100;
        textColor = Colors.blue.shade800;
        break;
      default:
        backgroundColor = Colors.grey.shade100;
        textColor = Colors.grey.shade800;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  String _formatDateTime(DateTime date) {
    return '${date.day}/${date.month}/${date.year} a las ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}