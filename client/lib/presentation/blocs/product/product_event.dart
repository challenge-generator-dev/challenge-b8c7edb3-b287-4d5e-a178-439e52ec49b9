package pedidos_app.presentation.blocs.product;

import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class LoadProducts extends ProductEvent {
  const LoadProducts();

  @override
  List<Object?> get props => [];
}

class RefreshProducts extends ProductEvent {
  final bool forceRefresh;

  const RefreshProducts({this.forceRefresh = false});

  @override
  List<Object?> get props => [forceRefresh];
}

class SearchProducts extends ProductEvent {
  final String query;

  const SearchProducts(this.query);

  @override
  List<Object?> get props => [query];
}

class FilterProductsByCategory extends ProductEvent {
  final String? categoryId;

  const FilterProductsByCategory(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}

class SelectProduct extends ProductEvent {
  final String productId;

  const SelectProduct(this.productId);

  @override
  List<Object?> get props => [productId];
}

class ClearProductSelection extends ProductEvent {
  const ClearProductSelection();
}

class LoadProductDetails extends ProductEvent {
  final String productId;

  const LoadProductDetails(this.productId);

  @override
  List<Object?> get props => [productId];
}

class ClearProductError extends ProductEvent {
  const ClearProductError();
}