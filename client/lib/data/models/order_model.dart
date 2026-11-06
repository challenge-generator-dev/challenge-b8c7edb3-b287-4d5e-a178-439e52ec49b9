package pedidos_app.data.models;

import 'package:equatable/equatable.dart';

class OrderModel extends Equatable {
  final String id;
  final String customerId;
  final String customerName;
  final String status;
  final List<OrderItemModel> items;
  final double totalAmount;
  final String currency;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? shippingAddress;
  final String? notes;

  const OrderModel({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.status,
    required this.items,
    required this.totalAmount,
    required this.currency,
    required this.createdAt,
    this.updatedAt,
    this.shippingAddress,
    this.notes,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] as String? ?? '',
      customerId: json['customer_id'] as String? ?? '',
      customerName: json['customer_name'] as String? ?? '',
      status: json['status'] as String? ?? 'pending',
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => OrderItemModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      totalAmount: _parseDouble(json['total_amount']),
      currency: json['currency'] as String? ?? 'USD',
      createdAt: _parseDateTime(json['created_at']),
      updatedAt: _parseNullableDateTime(json['updated_at']),
      shippingAddress: json['shipping_address'] as String?,
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customer_id': customerId,
      'customer_name': customerName,
      'status': status,
      'items': items.map((e) => e.toJson()).toList(),
      'total_amount': totalAmount,
      'currency': currency,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'shipping_address': shippingAddress,
      'notes': notes,
    };
  }

  static double _parseDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  static DateTime _parseDateTime(dynamic value) {
    if (value == null) return DateTime.now();
    if (value is String) return DateTime.tryParse(value) ?? DateTime.now();
    if (value is int) return DateTime.fromMillisecondsSinceEpoch(value);
    return DateTime.now();
  }

  static DateTime? _parseNullableDateTime(dynamic value) {
    if (value == null) return null;
    if (value is String) return DateTime.tryParse(value);
    if (value is int) return DateTime.fromMillisecondsSinceEpoch(value);
    return null;
  }

  OrderModel copyWith({
    String? id,
    String? customerId,
    String? customerName,
    String? status,
    List<OrderItemModel>? items,
    double? totalAmount,
    String? currency,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? shippingAddress,
    String? notes,
  }) {
    return OrderModel(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      customerName: customerName ?? this.customerName,
      status: status ?? this.status,
      items: items ?? this.items,
      totalAmount: totalAmount ?? this.totalAmount,
      currency: currency ?? this.currency,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      notes: notes ?? this.notes,
    );
  }

  @override
  List<Object?> get props => [
        id,
        customerId,
        customerName,
        status,
        items,
        totalAmount,
        currency,
        createdAt,
        updatedAt,
        shippingAddress,
        notes,
      ];
}

class OrderItemModel extends Equatable {
  final String productId;
  final String productName;
  final int quantity;
  final double unitPrice;
  final double subtotal;

  const OrderItemModel({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
    required this.subtotal,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      productId: json['product_id'] as String? ?? '',
      productName: json['product_name'] as String? ?? '',
      quantity: json['quantity'] as int? ?? 0,
      unitPrice: _parseDouble(json['unit_price']),
      subtotal: _parseDouble(json['subtotal']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'product_name': productName,
      'quantity': quantity,
      'unit_price': unitPrice,
      'subtotal': subtotal,
    };
  }

  static double _parseDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  @override
  List<Object?> get props => [
        productId,
        productName,
        quantity,
        unitPrice,
        subtotal,
      ];
}

class CreateOrderRequest extends Equatable {
  final String customerId;
  final String customerName;
  final List<CreateOrderItemRequest> items;
  final String? shippingAddress;
  final String? notes;

  const CreateOrderRequest({
    required this.customerId,
    required this.customerName,
    required this.items,
    this.shippingAddress,
    this.notes,
  });

  Map<String, dynamic> toJson() {
    return {
      'customer_id': customerId,
      'customer_name': customerName,
      'items': items.map((e) => e.toJson()).toList(),
      'shipping_address': shippingAddress,
      'notes': notes,
    };
  }

  @override
  List<Object?> get props => [
        customerId,
        customerName,
        items,
        shippingAddress,
        notes,
      ];
}

class CreateOrderItemRequest extends Equatable {
  final String productId;
  final int quantity;

  const CreateOrderItemRequest({
    required this.productId,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'quantity': quantity,
    };
  }

  @override
  List<Object?> get props => [productId, quantity];
}