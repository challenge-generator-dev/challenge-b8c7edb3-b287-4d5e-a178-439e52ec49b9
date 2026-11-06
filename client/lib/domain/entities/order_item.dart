package pedidos_app.domain.entities;

import 'package:equatable/equatable.dart';

/// Entidad de dominio que representa un item individual dentro de un pedido.
///
/// Cada [OrderItem] corresponde a un producto específico solicitado
/// en un pedido, incluyendo la cantidad, precio unitario y cálculos
/// derivados como el subtotal.
class OrderItem extends Equatable {
  /// Identificador único del item en el pedido.
  final String id;

  /// Identificador del producto asociado.
  final String productId;

  /// Nombre del producto al momento de realizar el pedido.
  final String productName;

  /// Descripción adicional del producto.
  final String? productDescription;

  /// URL de la imagen del producto.
  final String? productImageUrl;

  /// Cantidad solicitada del producto.
  final int quantity;

  /// Precio unitario del producto en el momento del pedido.
  final double unitPrice;

  /// Porcentaje de descuento aplicado a este item, si existe.
  final double discountPercentage;

  /// Notas especiales para este item específicas del cliente.
  final String? specialInstructions;

  /// Constructor completo de la entidad OrderItem.
  ///
  /// [quantity] debe ser mayor a 0 y [unitPrice] no puede ser negativo.
  const OrderItem({
    required this.id,
    required this.productId,
    required this.productName,
    this.productDescription,
    this.productImageUrl,
    required this.quantity,
    required this.unitPrice,
    this.discountPercentage = 0.0,
    this.specialInstructions,
  });

  /// Calcula el precio unitario después de aplicar el descuento.
  ///
  /// Retorna el precio con el descuento ya calculado,
  /// permitiendo obtener el valor real a pagar por unidad.
  double get discountedUnitPrice {
    if (discountPercentage <= 0) return unitPrice;
    final discount = unitPrice * (discountPercentage / 100);
    return unitPrice - discount;
  }

  /// Calcula el subtotal del item sin aplicar descuentos.
  ///
  /// Es el resultado de multiplicar la cantidad por el precio
  /// unitario original, antes de descuentos.
  double get rawSubtotal {
    return quantity * unitPrice;
  }

  /// Calcula el subtotal del item con descuentos aplicados.
  ///
  /// Es el resultado de multiplicar la cantidad por el precio
  /// unitario con descuento ya calculado.
  double get subtotal {
    return quantity * discountedUnitPrice;
  }

  /// Calcula el monto total de descuento aplicado a este item.
  ///
  /// Retorna la diferencia entre el subtotal sin descuento
  /// y el subtotal con descuento.
  double get discountAmount {
    return rawSubtotal - subtotal;
  }

  /// Verifica si este item tiene algún descuento aplicado.
  bool get hasDiscount => discountPercentage > 0;

  /// Verifica si la cantidad solicitada está disponible.
  ///
  /// Este método será implementado con la lógica de validación
  /// contra el stock disponible del producto.
  bool isQuantityValid(int availableStock) {
    return quantity > 0 && quantity <= availableStock;
  }

  /// Crea una copia del item con los campos actualizados.
  OrderItem copyWith({
    String? id,
    String? productId,
    String? productName,
    String? productDescription,
    String? productImageUrl,
    int? quantity,
    double? unitPrice,
    double? discountPercentage,
    String? specialInstructions,
  }) {
    return OrderItem(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productDescription: productDescription ?? this.productDescription,
      productImageUrl: productImageUrl ?? this.productImageUrl,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      specialInstructions: specialInstructions ?? this.specialInstructions,
    );
  }

  @override
  List<Object?> get props => [
        id,
        productId,
        productName,
        productDescription,
        productImageUrl,
        quantity,
        unitPrice,
        discountPercentage,
        specialInstructions,
      ];
}