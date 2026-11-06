package pedidos_app.domain.repositories;

import 'package:dartz/dartz.dart';
import 'package:pedidos_app/core/errors/failures.dart';
import 'package:pedidos_app/domain/entities/product.dart';

abstract class ProductRepository {
  /// Obtiene todos los productos disponibles en el catálogo.
  /// Retorna [Either] con [Failure] en caso de error o [List<Product>] en caso de éxito.
  Future<Either<Failure, List<Product>>> getProducts();

  /// Obtiene un producto específico por su identificador.
  /// [id] - Identificador único del producto.
  /// Retorna [Either] con [Failure] o [Product] encontrado.
  Future<Either<Failure, Product>> getProductById(String id);

  /// Busca productos por término de búsqueda.
  /// [query] - Término de búsqueda en nombre o descripción.
  /// Retorna [Either] con [Failure] o [List<Product>] que coinciden.
  Future<Either<Failure, List<Product>>> searchProducts(String query);

  /// Obtiene los productos destacados para mostrar en pantalla principal.
  /// Retorna [Either] con [Failure] o [List<Product>] destacados.
  Future<Either<Failure, List<Product>>> getFeaturedProducts();

  /// Obtiene los productos por categoría.
  /// [categoryId] - Identificador de la categoría.
  /// Retorna [Either] con [Failure] o [List<Product>] de esa categoría.
  Future<Either<Failure, List<Product>>> getProductsByCategory(String categoryId);
}