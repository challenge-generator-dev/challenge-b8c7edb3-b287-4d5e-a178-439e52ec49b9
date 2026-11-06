package pedidos_app.data.models;

import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final String id;
  final String name;
  final String description;
  final double price;
  final String currency;
  final String category;
  final String? imageUrl;
  final int stockQuantity;
  final bool isAvailable;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final Map<String, dynamic>? metadata;

  const ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.currency,
    required this.category,
    this.imageUrl,
    required this.stockQuantity,
    required this.isAvailable,
    required this.createdAt,
    this.updatedAt,
    this.metadata,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      price: _parseDouble(json['price']),
      currency: json['currency'] as String? ?? 'USD',
      category: json['category'] as String? ?? 'general',
      imageUrl: json['image_url'] as String?,
      stockQuantity: json['stock_quantity'] as int? ?? 0,
      isAvailable: json['is_available'] as bool? ?? true,
      createdAt: _parseDateTime(json['created_at']),
      updatedAt: _parseNullableDateTime(json['updated_at']),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'currency': currency,
      'category': category,
      'image_url': imageUrl,
      'stock_quantity': stockQuantity,
      'is_available': isAvailable,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'metadata': metadata,
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

  ProductModel copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? currency,
    String? category,
    String? imageUrl,
    int? stockQuantity,
    bool? isAvailable,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, dynamic>? metadata,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      category: category ?? this.category,
      imageUrl: imageUrl ?? this.imageUrl,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      isAvailable: isAvailable ?? this.isAvailable,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      metadata: metadata ?? this.metadata,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        price,
        currency,
        category,
        imageUrl,
        stockQuantity,
        isAvailable,
        createdAt,
        updatedAt,
        metadata,
      ];
}