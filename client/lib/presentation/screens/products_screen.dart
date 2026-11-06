package pedidos_app.presentation.screens;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pedidos_app/domain/entities/product.dart';
import 'package:pedidos_app/presentation/blocs/product/product_bloc.dart';
import 'package:pedidos_app/presentation/blocs/product/product_event.dart';
import 'package:pedidos_app/presentation/blocs/product/product_state.dart';
import 'package:pedidos_app/core/errors/failures.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(LoadProductsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo de Productos'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<ProductBloc>().add(LoadProductsEvent());
            },
            tooltip: 'Actualizar productos',
          ),
        ],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Cargando productos...'),
                ],
              ),
            );
          }

          if (state is ProductError) {
            return _buildErrorWidget(state.failure);
          }

          if (state is ProductLoaded) {
            return _buildProductsList(state.products);
          }

          return const Center(
            child: Text('Iniciando carga de productos...'),
          );
        },
      ),
    );
  }

  Widget _buildErrorWidget(Failure failure) {
    final String message;
    final IconData icon;
    final Color backgroundColor;

    if (failure is NetworkFailure) {
      message = 'Sin conexión a internet. Verifica tu conexión e intenta nuevamente.';
      icon = Icons.wifi_off;
      backgroundColor = Colors.orange.shade100;
    } else if (failure is ServerFailure) {
      message = 'Error del servidor: ${failure.message}';
      icon = Icons.cloud_off;
      backgroundColor = Colors.red.shade100;
    } else if (failure is CacheFailure) {
      message = 'Error al cargar datos locales.';
      icon = Icons.storage;
      backgroundColor = Colors.amber.shade100;
    } else if (failure is OfflineFailure) {
      message = 'Estás sin conexión. некоторые функции pueden estar limitadas.';
      icon = Icons.signal_wifi_connected_no_internet_4;
      backgroundColor = Colors.grey.shade300;
    } else {
      message = 'Ocurrió un error inesperado: ${failure.message}';
      icon = Icons.error_outline;
      backgroundColor = Colors.red.shade50;
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: backgroundColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 48,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                context.read<ProductBloc>().add(LoadProductsEvent());
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Reintentar'),
              style: ElevatedButton.styleFrom(
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

  Widget _buildProductsList(List<Product> products) {
    if (products.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inventory_2_outlined,
              size: 80,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              'No hay productos disponibles',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Pronto añadiremos nuevos productos',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        context.read<ProductBloc>().add(LoadProductsEvent());
        await Future.delayed(const Duration(milliseconds: 500));
      },
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return _ProductCard(product: product);
        },
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final Product product;

  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final priceFormatted = '\$${product.price.toStringAsFixed(2)}';

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () => _showProductDetails(context),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProductImage(),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    if (product.description != null &&
                        product.description!.isNotEmpty)
                      Text(
                        product.description!,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          priceFormatted,
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        _buildAvailabilityBadge(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductImage() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: product.imageUrl != null && product.imageUrl!.isNotEmpty
          ? ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                product.imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return _buildPlaceholderIcon();
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                      strokeWidth: 2,
                    ),
                  );
                },
              ),
            )
          : _buildPlaceholderIcon(),
    );
  }

  Widget _buildPlaceholderIcon() {
    return Icon(
      Icons.shopping_bag_outlined,
      size: 32,
      color: Colors.grey.shade400,
    );
  }

  Widget _buildAvailabilityBadge() {
    final bool isAvailable = product.isAvailable;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isAvailable ? Colors.green.shade100 : Colors.red.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        isAvailable ? 'Disponible' : 'Agotado',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: isAvailable ? Colors.green.shade800 : Colors.red.shade800,
        ),
      ),
    );
  }

  void _showProductDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    product.name,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  if (product.imageUrl != null && product.imageUrl!.isNotEmpty)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        product.imageUrl!,
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: double.infinity,
                            height: 200,
                            color: Colors.grey.shade200,
                            child: Icon(
                              Icons.image_not_supported,
                              size: 48,
                              color: Colors.grey.shade400,
                            ),
                          );
                        },
                      ),
                    ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style:
                            Theme.of(context).textTheme.headlineMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      _buildAvailabilityBadge(),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Descripción',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description ?? 'Sin descripción disponible',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 24),
                  if (product.category != null) ...[
                    Text(
                      'Categoría',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Chip(
                      label: Text(product.category!),
                      backgroundColor: Theme.of(context)
                          .colorScheme
                          .primaryContainer
                          .withOpacity(0.5),
                    ),
                    const SizedBox(height: 24),
                  ],
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: product.isAvailable
                          ? () {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '${product.name} añadido al carrito',
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                  action: SnackBarAction(
                                    label: 'Deshacer',
                                    onPressed: () {},
                                  ),
                                ),
                              );
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        product.isAvailable
                            ? 'Añadir al carrito'
                            : 'Producto no disponible',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}