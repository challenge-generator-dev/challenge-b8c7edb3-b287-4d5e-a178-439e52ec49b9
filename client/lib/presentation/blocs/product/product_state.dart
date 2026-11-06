package pedidos_app.presentation.blocs.product;

import 'package:equatable/equatable.dart';
import 'package:pedidos_app/domain/entities/product.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {
  const ProductInitial();
}

class ProductLoading extends ProductState {
  final List<Product> currentProducts;

  const ProductLoading({this.currentProducts = const []});

  @override
  List<Object?> get props => [currentProducts];
}

class ProductLoaded extends ProductState {
  final List<Product> products;
  final Product? selectedProduct;
  final String? activeCategoryFilter;
  final String? searchQuery;
  final bool isRefreshing;
  final DateTime lastUpdated;

  const ProductLoaded({
    required this.products,
    this.selectedProduct,
    this.activeCategoryFilter,
    this.searchQuery,
    this.isRefreshing = false,
    required this.lastUpdated,
  });

  ProductLoaded copyWith({
    List<Product>? products,
    Product? selectedProduct,
    bool clearSelection = false,
    String? activeCategoryFilter,
    bool clearCategoryFilter = false,
    String? searchQuery,
    bool clearSearchQuery = false,
    bool? isRefreshing,
    DateTime? lastUpdated,
  }) {
    return ProductLoaded(
      products: products ?? this.products,
      selectedProduct: clearSelection ? null : (selectedProduct ?? this.selectedProduct),
      activeCategoryFilter: clearCategoryFilter ? null : (activeCategoryFilter ?? this.activeCategoryFilter),
      searchQuery: clearSearchQuery ? null : (searchQuery ?? this.searchQuery),
      isRefreshing: isRefreshing ?? this.isRefreshing,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  List<Product> get filteredProducts {
    var result = products;

    if (activeCategoryFilter != null && activeCategoryFilter!.isNotEmpty) {
      result = result.where((p) => p.categoryId == activeCategoryFilter).toList();
    }

    if (searchQuery != null && searchQuery!.isNotEmpty) {
      final query = searchQuery!.toLowerCase();
      result = result.where((p) => 
        p.name.toLowerCase().contains(query) ||
        p.description.toLowerCase().contains(query)
      ).toList();
    }

    return result;
  }

  @override
  List<Object?> get props => [
    products,
    selectedProduct,
    activeCategoryFilter,
    searchQuery,
    isRefreshing,
    lastUpdated,
  ];
}

class ProductError extends ProductState {
  final String message;
  final List<Product> previousProducts;
  final bool canRetry;

  const ProductError({
    required this.message,
    this.previousProducts = const [],
    this.canRetry = true,
  });

  ProductError copyWith({
    String? message,
    List<Product>? previousProducts,
    bool? canRetry,
  }) {
    return ProductError(
      message: message ?? this.message,
      previousProducts: previousProducts ?? this.previousProducts,
      canRetry: canRetry ?? this.canRetry,
    );
  }

  @override
  List<Object?> get props => [message, previousProducts, canRetry];
}

class ProductOperationSuccess extends ProductState {
  final String message;
  final Product? product;
  final List<Product> updatedProducts;

  const ProductOperationSuccess({
    required this.message,
    this.product,
    required this.updatedProducts,
  });

  @override
  List<Object?> get props => [message, product, updatedProducts];
}