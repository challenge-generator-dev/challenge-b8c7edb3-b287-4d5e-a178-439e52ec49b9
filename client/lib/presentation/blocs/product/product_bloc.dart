package pedidos_app.presentation.blocs.product;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:pedidos_app/domain/entities/product.dart';
import 'package:pedidos_app/domain/repositories/product_repository.dart';
import 'package:pedidos_app/core/errors/failures.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;

  ProductBloc({required this.productRepository}) : super(const ProductInitial()) {
    on<LoadProducts>(_onLoadProducts);
    on<RefreshProducts>(_onRefreshProducts);
    on<SearchProducts>(_onSearchProducts);
    on<FilterProductsByCategory>(_onFilterProductsByCategory);
    on<SelectProduct>(_onSelectProduct);
    on<ClearProductSelection>(_onClearProductSelection);
    on<LoadProductDetails>(_onLoadProductDetails);
    on<ClearProductError>(_onClearProductError);
  }

  Future<void> _onLoadProducts(
    LoadProducts event,
    Emitter<ProductState> emit,
  ) async {
    final currentState = state;
    List<Product> currentProducts = [];
    
    if (currentState is ProductLoaded) {
      currentProducts = currentState.products;
    }

    emit(ProductLoading(currentProducts: currentProducts));

    final result = await productRepository.getProducts();

    result.fold(
      (failure) => emit(ProductError(
        message: _mapFailureToMessage(failure),
        previousProducts: currentProducts,
        canRetry: true,
      )),
      (products) => emit(ProductLoaded(
        products: products,
        lastUpdated: DateTime.now(),
      )),
    );
  }

  Future<void> _onRefreshProducts(
    RefreshProducts event,
    Emitter<ProductState> emit,
  ) async {
    final currentState = state;
    
    if (currentState is ProductLoaded) {
      emit(currentState.copyWith(isRefreshing: true));
    }

    final Either<Failure, List<Product>> result;
    
    if (event.forceRefresh) {
      result = await productRepository.getProducts();
    } else {
      result = await productRepository.getProducts();
    }

    result.fold(
      (failure) {
        if (currentState is ProductLoaded) {
          emit(ProductError(
            message: _mapFailureToMessage(failure),
            previousProducts: currentState.products,
            canRetry: true,
          ));
        } else {
          emit(ProductError(
            message: _mapFailureToMessage(failure),
            previousProducts: const [],
            canRetry: true,
          ));
        }
      },
      (products) {
        final newState = ProductLoaded(
          products: products,
          activeCategoryFilter: currentState is ProductLoaded ? currentState.activeCategoryFilter : null,
          searchQuery: currentState is ProductLoaded ? currentState.searchQuery : null,
          lastUpdated: DateTime.now(),
        );
        emit(newState);
      },
    );
  }

  void _onSearchProducts(
    SearchProducts event,
    Emitter<ProductState> emit,
  ) {
    final currentState = state;
    
    if (currentState is ProductLoaded) {
      if (event.query.isEmpty) {
        emit(currentState.copyWith(clearSearchQuery: true));
      } else {
        emit(currentState.copyWith(searchQuery: event.query));
      }
    }
  }

  void _onFilterProductsByCategory(
    FilterProductsByCategory event,
    Emitter<ProductState> emit,
  ) {
    final currentState = state;
    
    if (currentState is ProductLoaded) {
      if (event.categoryId == null || event.categoryId!.isEmpty) {
        emit(currentState.copyWith(clearCategoryFilter: true));
      } else {
        emit(currentState.copyWith(activeCategoryFilter: event.categoryId));
      }
    }
  }

  Future<void> _onSelectProduct(
    SelectProduct event,
    Emitter<ProductState> emit,
  ) async {
    final currentState = state;
    
    if (currentState is ProductLoaded) {
      final product = currentState.products.firstWhere(
        (p) => p.id == event.productId,
        orElse: () => throw Exception('Producto no encontrado'),
      );
      
      emit(currentState.copyWith(selectedProduct: product));
    }
  }

  void _onClearProductSelection(
    ClearProductSelection event,
    Emitter<ProductState> emit,
  ) {
    final currentState = state;
    
    if (currentState is ProductLoaded) {
      emit(currentState.copyWith(clearSelection: true));
    }
  }

  Future<void> _onLoadProductDetails(
    LoadProductDetails event,
    Emitter<ProductState> emit,
  ) async {
    final currentState = state;
    
    if (currentState is ProductLoaded) {
      final product = currentState.products.firstWhere(
        (p) => p.id == event.productId,
        orElse: () => throw Exception('Producto no encontrado'),
      );
      
      emit(currentState.copyWith(selectedProduct: product));
    } else {
      final result = await productRepository.getProductById(event.productId);
      
      result.fold(
        (failure) => emit(ProductError(
          message: _mapFailureToMessage(failure),
          canRetry: true,
        )),
        (product) {
          if (currentState is ProductLoaded) {
            emit(currentState.copyWith(selectedProduct: product));
          } else {
            emit(ProductLoaded(
              products: [product],
              selectedProduct: product,
              lastUpdated: DateTime.now(),
            ));
          }
        },
      );
    }
  }

  void _onClearProductError(
    ClearProductError event,
    Emitter<ProductState> emit,
  ) {
    final currentState = state;
    
    if (currentState is ProductError) {
      if (currentState.previousProducts.isNotEmpty) {
        emit(ProductLoaded(
          products: currentState.previousProducts,
          lastUpdated: DateTime.now(),
        ));
      } else {
        emit(const ProductInitial());
      }
    }
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return failure.message;
    } else if (failure is NetworkFailure) {
      return 'Error de conexión. Verifica tu conexión a internet.';
    } else if (failure is CacheFailure) {
      return 'Error al acceder a datos locales.';
    } else if (failure is OfflineFailure) {
      return 'Sin conexión a internet. Por favor, verifica tu red.';
    } else {
      return 'Ha ocurrido un error inesperado.';
    }
  }
}