package pedidos_app.domain.repositories;

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pedidos_app/core/errors/failures.dart';
import 'package:pedidos_app/domain/entities/order.dart';

abstract class OrderRepository {
  /// Obtiene todos los pedidos del sistema.
  /// Retorna [Either] con [Failure] en caso de error o [List<Order>] en caso de éxito.
  Future<Either<Failure, List<Order>>> getOrders();

  /// Obtiene un pedido específico por su identificador.
  /// [id] - Identificador único del pedido.
  /// Retorna [Either] con [Failure] o [Order] encontrado.
  Future<Either<Failure, Order>> getOrderById(String id);

  /// Crea un nuevo pedido en el sistema.
  /// [request] - Datos necesarios para crear el pedido.
  /// Retorna [Either] con [Failure] o el [Order] creado.
  Future<Either<Failure, Order>> createOrder(CreateOrderRequest request);
}

class CreateOrderRequest extends Equatable {
  final String clientId;
  final String clientName;
  final String clientEmail;
  final String clientPhone;
  final String deliveryAddress;
  final List<OrderItemRequest> items;
  final String? notes;

  const CreateOrderRequest({
    required this.clientId,
    required this.clientName,
    required this.clientEmail,
    required this.clientPhone,
    required this.deliveryAddress,
    required this.items,
    this.notes,
  });

  Map<String, dynamic> toJson() {
    return {
      'clientId': clientId,
      'clientName': clientName,
      'clientEmail': clientEmail,
      'clientPhone': clientPhone,
      'deliveryAddress': deliveryAddress,
      'items': items.map((item) => item.toJson()).toList(),
      if (notes != null) 'notes': notes,
    };
  }

  @override
  List<Object?> get props => [
        clientId,
        clientName,
        clientEmail,
        clientPhone,
        deliveryAddress,
        items,
        notes,
      ];
}

class OrderItemRequest extends Equatable {
  final String productId;
  final String productName;
  final int quantity;
  final double unitPrice;

  const OrderItemRequest({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
  });

  double get subtotal => quantity * unitPrice;

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'quantity': quantity,
      'unitPrice': unitPrice,
    };
  }

  @override
  List<Object?> get props => [productId, productName, quantity, unitPrice];
}