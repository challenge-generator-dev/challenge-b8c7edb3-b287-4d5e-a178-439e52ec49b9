package pedidos_app.domain.entities;

import 'package:equatable/equatable.dart';
import 'order_item.dart';

/// Entidad de dominio que representa un pedido en el sistema.
///
/// Esta clase encapsula toda la información relevante de un pedido,
/// incluyendo su identificador único, estado actual, items solicitados,
/// información del cliente, totales y fechas importantes.
///
/// La entidad es inmutable y utiliza [Equatable] para permitir
/// comparaciones por valor, lo cual es esencial para el correcto
/// funcionamiento del sistema de estado con BLoC.
class Order extends Equatable {
  /// Identificador único del pedido.
  final String id;

  /// Identificador del cliente que realizó el pedido.
  final String customerId;

  /// Nombre del cliente para display.
  final String customerName;

  /// Correo electrónico del cliente.
  final String? customerEmail;

  /// Teléfono de contacto del cliente.
  final String? customerPhone;

  /// Lista de items incluidos en el pedido.
  final List<OrderItem> items;

  /// Subtotal del pedido sin impuestos ni descuentos.
  final double subtotal;

  /// Monto del impuesto aplicado.
  final double taxAmount;

  /// Monto de descuento aplicado, si existe.
  final double discountAmount;

  /// Total final del pedido incluyendo todos los cargos.
  final double totalAmount;

  /// Estado actual del pedido en el sistema.
  final OrderStatus status;

  /// Fecha y hora en que se creó el pedido.
  final DateTime createdAt;

  /// Fecha y hora de la última actualización del pedido.
  final DateTime updatedAt;

  /// Dirección de entrega del pedido.
  final String? deliveryAddress;

  /// Notas adicionales proporcionadas por el cliente.
  final String? notes;

  /// Método de pago seleccionado.
  final PaymentMethod paymentMethod;

  /// Indica si el pedido ha sido pagado.
  final bool isPaid;

  /// Identificador de la transacción de pago, si aplica.
  final String? paymentTransactionId;

  /// Constructor completo de la entidad Order.
  ///
  /// Todos los campos son requeridos excepto aquellos marcados como opcionales.
  const Order({
    required this.id,
    required this.customerId,
    required this.customerName,
    this.customerEmail,
    this.customerPhone,
    required this.items,
    required this.subtotal,
    required this.taxAmount,
    this.discountAmount = 0.0,
    required this.totalAmount,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.deliveryAddress,
    this.notes,
    required this.paymentMethod,
    this.isPaid = false,
    this.paymentTransactionId,
  });

  /// Retorna el número total de items en el pedido.
  ///
  /// Suma las cantidades de cada [OrderItem] para obtener
  /// la cantidad total de productos solicitados.
  int get totalItems {
    if (items.isEmpty) return 0;
    return items.fold<int>(0, (sum, item) => sum + item.quantity);
  }

  /// Verifica si el pedido puede ser cancelado.
  ///
  /// Un pedido solo puede cancelarse si su estado actual
  /// es [OrderStatus.pending] o [OrderStatus.confirmed].
  bool get canCancel {
    return status == OrderStatus.pending ||
        status == OrderStatus.confirmed;
  }

  /// Verifica si el pedido puede ser modificado.
  ///
  /// Un pedido puede modificarse únicamente si está en estado
  /// [OrderStatus.pending], permitiendo agregar o quitar items.
  bool get canModify {
    return status == OrderStatus.pending;
  }

  /// Verifica si el pedido está en un estado activo.
  ///
  /// Un pedido se considera activo cuando no ha sido
  /// completado, cancelado ni rechazado.
  bool get isActive {
    return status != OrderStatus.completed &&
        status != OrderStatus.cancelled &&
        status != OrderStatus.rejected;
  }

  /// Crea una copia de la orden con los campos actualizados.
  ///
  /// Utilizado para crear nuevas versiones de la orden
  /// cuando se modifican atributos específicos.
  Order copyWith({
    String? id,
    String? customerId,
    String? customerName,
    String? customerEmail,
    String? customerPhone,
    List<OrderItem>? items,
    double? subtotal,
    double? taxAmount,
    double? discountAmount,
    double? totalAmount,
    OrderStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? deliveryAddress,
    String? notes,
    PaymentMethod? paymentMethod,
    bool? isPaid,
    String? paymentTransactionId,
  }) {
    return Order(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      customerName: customerName ?? this.customerName,
      customerEmail: customerEmail ?? this.customerEmail,
      customerPhone: customerPhone ?? this.customerPhone,
      items: items ?? this.items,
      subtotal: subtotal ?? this.subtotal,
      taxAmount: taxAmount ?? this.taxAmount,
      discountAmount: discountAmount ?? this.discountAmount,
      totalAmount: totalAmount ?? this.totalAmount,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      notes: notes ?? this.notes,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      isPaid: isPaid ?? this.isPaid,
      paymentTransactionId: paymentTransactionId ?? this.paymentTransactionId,
    );
  }

  @override
  List<Object?> get props => [
        id,
        customerId,
        customerName,
        customerEmail,
        customerPhone,
        items,
        subtotal,
        taxAmount,
        discountAmount,
        totalAmount,
        status,
        createdAt,
        updatedAt,
        deliveryAddress,
        notes,
        paymentMethod,
        isPaid,
        paymentTransactionId,
      ];
}

/// Enumeración que representa los posibles estados de un pedido.
///
/// Cada estado representa una etapa en el ciclo de vida del pedido,
/// desde su creación hasta su entrega o cancelación.
enum OrderStatus {
  /// Pedido creado, esperando confirmación del sistema.
  pending,

  /// Pedido confirmado y preparado para procesamiento.
  confirmed,

  /// Pedido en proceso de preparación.
  preparing,

  /// Pedido listo para entrega o recolección.
  ready,

  /// Pedido en tránsito hacia el cliente.
  inTransit,

  /// Pedido entregado exitosamente.
  completed,

  /// Pedido cancelado por el cliente o sistema.
  cancelled,

  /// Pedido rechazado por el proveedor.
  rejected,
}

/// Extensión que añade funcionalidad adicional a [OrderStatus].
///
/// Proporciona métodos de utilidad para trabajar con
/// los estados de manera más expresiva.
extension OrderStatusExtension on OrderStatus {
  /// Retorna el nombre legible del estado para display en UI.
  String get displayName {
    switch (this) {
      case OrderStatus.pending:
        return 'Pendiente';
      case OrderStatus.confirmed:
        return 'Confirmado';
      case OrderStatus.preparing:
        return 'Preparando';
      case OrderStatus.ready:
        return 'Listo';
      case OrderStatus.inTransit:
        return 'En camino';
      case OrderStatus.completed:
        return 'Entregado';
      case OrderStatus.cancelled:
        return 'Cancelado';
      case OrderStatus.rejected:
        return 'Rechazado';
    }
  }

  /// Indica si el estado representa un estado terminal.
  ///
  /// Los estados terminales no permiten transiciones adicionales.
  bool get isTerminal {
    return this == OrderStatus.completed ||
        this == OrderStatus.cancelled ||
        this == OrderStatus.rejected;
  }

  /// Indica si el estado permite modificaciones en el pedido.
  bool get allowsModification {
    return this == OrderStatus.pending;
  }
}

/// Enumeración que representa los métodos de pago disponibles.
enum PaymentMethod {
  /// Pago en efectivo contra entrega.
  cashOnDelivery,

  /// Pago con tarjeta de crédito o débito.
  card,

  /// Pago a través de transferencia bancaria.
  bankTransfer,

  /// Pago mediante billetera digital.
  digitalWallet,
}

/// Extensión que añade funcionalidad adicional a [PaymentMethod].
extension PaymentMethodExtension on PaymentMethod {
  /// Retorna el nombre legible del método de pago.
  String get displayName {
    switch (this) {
      case PaymentMethod.cashOnDelivery:
        return 'Efectivo contra entrega';
      case PaymentMethod.card:
        return 'Tarjeta';
      case PaymentMethod.bankTransfer:
        return 'Transferencia bancaria';
      case PaymentMethod.digitalWallet:
        return 'Billetera digital';
    }
  }
}