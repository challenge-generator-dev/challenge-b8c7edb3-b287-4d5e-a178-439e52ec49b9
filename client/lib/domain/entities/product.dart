package pedidos_app.domain.entities;

import 'package:equatable/equatable.dart';

/// Entidad de dominio que representa un producto disponible en el sistema.
///
/// Un producto es cualquier artículo que puede ser incluido en un pedido.
/// La entidad contiene toda la información relevante para la visualización
/// en el catálogo y para el procesamiento del pedido.
class Product extends Equatable {
  /// Identificador único del producto.
  final String id;

  /// Nombre del producto.
  final String name;

  /// Descripción detallada del producto.
  final String description;

  /// Precio base del producto.
  final double price;

  /// Categoría a la que pertenece el producto.
  final String category;

  /// URL de la imagen principal del producto.
  final String? imageUrl;

  /// Lista de URLs de imágenes adicionales del producto.
  final List<String> additionalImages;

  /// Indica si el producto está disponible para pedidos.
  final bool isAvailable;

  /// Cantidad actual en inventario.
  final int stockQuantity;

  /// Stock mínimo que activa alerta de reposición.
  final int? minimumStockThreshold;

  /// Código SKU del producto para gestión de inventario.
  final String? sku;

  /// Código de barras del producto.
  final String? barcode;

  /// Peso del producto en kilogramos.
  final double? weight;

  /// Dimensiones del producto (alto, ancho, profundidad) en centímetros.
  final ProductDimensions? dimensions;

  /// Fecha de creación del producto en el sistema.
  final DateTime createdAt;

  /// Fecha de la última actualización del producto.
  final DateTime updatedAt;

  /// Indica si el producto está destacado en el catálogo.
  final bool isFeatured;

  /// Valoración promedio del producto basada en reseñas.
  final double? averageRating;

  /// Número total de reseñas del producto.
  final int reviewCount;

  /// Etiquetas asociadas al producto para búsqueda y filtros.
  final List<String> tags;

  /// Constructor completo de la entidad Product.
  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    this.imageUrl,
    this.additionalImages = const [],
    this.isAvailable = true,
    required this.stockQuantity,
    this.minimumStockThreshold,
    this.sku,
    this.barcode,
    this.weight,
    this.dimensions,
    required this.createdAt,
    required this.updatedAt,
    this.isFeatured = false,
    this.averageRating,
    this.reviewCount = 0,
    this.tags = const [],
  });

  /// Verifica si el producto tiene stock disponible.
  ///
  /// Un producto se considera disponible en stock cuando
  /// su cantidad es mayor a cero y está marcado como disponible.
  bool get hasStock => stockQuantity > 0 && isAvailable;

  /// Verifica si el stock está bajo el umbral mínimo.
  ///
  /// Activa una alerta cuando la cantidad en stock es menor
  /// o igual al umbral configurado, indicando necesidad de reposición.
  bool get isLowStock {
    if (minimumStockThreshold == null) return false;
    return stockQuantity <= minimumStockThreshold!;
  }

  /// Verifica si el producto está agotado.
  ///
  /// Un producto está agotado cuando su stock es cero
  /// o no está marcado como disponible.
  bool get isOutOfStock => stockQuantity <= 0 || !isAvailable;

  /// Retorna el precio formateado como cadena.
  ///
  /// Convierte el valor numérico a formato monetario
  /// con dos decimales.
  String get formattedPrice {
    return '\$${price.toStringAsFixed(2)}';
  }

  /// Verifica si el producto tiene imágenes adicionales.
  bool get hasAdditionalImages => additionalImages.isNotEmpty;

  /// Verifica si el producto tiene reseñas.
  bool get hasReviews => reviewCount > 0;

  /// Verifica si el producto puede agregarse al carrito con la cantidad solicitada.
  bool canAddToCart(int requestedQuantity) {
    return isAvailable && stockQuantity >= requestedQuantity;
  }

  /// Crea una copia del producto con los campos actualizados.
  Product copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? category,
    String? imageUrl,
    List<String>? additionalImages,
    bool? isAvailable,
    int? stockQuantity,
    int? minimumStockThreshold,
    String? sku,
    String? barcode,
    double? weight,
    ProductDimensions? dimensions,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isFeatured,
    double? averageRating,
    int? reviewCount,
    List<String>? tags,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      category: category ?? this.category,
      imageUrl: imageUrl ?? this.imageUrl,
      additionalImages: additionalImages ?? this.additionalImages,
      isAvailable: isAvailable ?? this.isAvailable,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      minimumStockThreshold: minimumStockThreshold ?? this.minimumStockThreshold,
      sku: sku ?? this.sku,
      barcode: barcode ?? this.barcode,
      weight: weight ?? this.weight,
      dimensions: dimensions ?? this.dimensions,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isFeatured: isFeatured ?? this.isFeatured,
      averageRating: averageRating ?? this.averageRating,
      reviewCount: reviewCount ?? this.reviewCount,
      tags: tags ?? this.tags,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        price,
        category,
        imageUrl,
        additionalImages,
        isAvailable,
        stockQuantity,
        minimumStockThreshold,
        sku,
        barcode,
        weight,
        dimensions,
        createdAt,
        updatedAt,
        isFeatured,
        averageRating,
        reviewCount,
        tags,
      ];
}

/// Entidad de valor que representa las dimensiones físicas de un producto.
///
/// Se utiliza para calcular costos de envío y para mostrar
/// información de empaque al cliente.
class ProductDimensions extends Equatable {
  /// Altura en centímetros.
  final double height;

  /// Ancho en centímetros.
  final double width;

  /// Profundidad en centímetros.
  final double depth;

  /// Constructor de las dimensiones del producto.
  const ProductDimensions({
    required this.height,
    required this.width,
    required this.depth,
  });

  /// Calcula el volumen total en centímetros cúbicos.
  double get volume => height * width * depth;

  /// Calcula el peso volumétrico para envío.
  ///
  /// El peso volumétrico es una medida estándar en logística
  /// que relaciona el volumen con el peso facturable.
  double get volumetricWeight => volume / 5000;

  /// Retorna las dimensiones formateadas como cadena.
  String get formatted => '${height}x${width}x${depth} cm';

  @override
  List<Object?> get props => [height, width, depth];
}

/// Extensión que añade funcionalidad adicional a la lista de productos.
///
/// Proporciona métodos de utilidad para filtrar y ordenar
/// colecciones de productos.
extension ProductListExtension on List<Product> {
  /// Filtra solo los productos disponibles para compra.
  List<Product> get available =>
      where((p) => p.isAvailable && p.stockQuantity > 0).toList();

  /// Filtra los productos destacados.
  List<Product> get featured => where((p) => p.isFeatured).toList();

  /// Filtra los productos con bajo stock.
  List<Product> get lowStock => where((p) => p.isLowStock).toList();

  /// Ordena los productos por precio ascendente.
  List<Product> sortByPriceAscending() {
    final sorted = List<Product>.from(this);
    sorted.sort((a, b) => a.price.compareTo(b.price));
    return sorted;
  }

  /// Ordena los productos por precio descendente.
  List<Product> sortByPriceDescending() {
    final sorted = List<Product>.from(this);
    sorted.sort((a, b) => b.price.compareTo(a.price));
    return sorted;
  }

  /// Filtra productos por categoría.
  List<Product> filterByCategory(String category) {
    return where((p) => p.category.toLowerCase() == category.toLowerCase()).toList();
  }

  /// Busca productos por nombre o descripción.
  List<Product> search(String query) {
    final lowerQuery = query.toLowerCase();
    return where((p) =>
        p.name.toLowerCase().contains(lowerQuery) ||
        p.description.toLowerCase().contains(lowerQuery) ||
        p.tags.any((tag) => tag.toLowerCase().contains(lowerQuery))).toList();
  }
}