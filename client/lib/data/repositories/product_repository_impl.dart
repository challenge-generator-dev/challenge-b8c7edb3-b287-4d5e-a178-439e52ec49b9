package pedidos_app.data.repositories;

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pedidos_app/core/errors/exceptions.dart';
import 'package:pedidos_app/core/errors/failures.dart';
import 'package:pedidos_app/data/datasources/product_remote_datasource.dart';
import 'package:pedidos_app/domain/entities/product.dart';
import 'package:pedidos_app/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    try {
      final productModels = await remoteDataSource.getProducts();
      final products = productModels.map((model) => model.toEntity()).toList();
      return Right(products);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
        statusCode: e.statusCode,
        errorCode: e.errorCode,
      ));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on ParseException catch (e) {
      return Left(ParseFailure(message: e.message));
    } on AuthenticationException catch (e) {
      return Left(AuthenticationFailure(message: e.message));
    } on OfflineException catch (e) {
      return Left(OfflineFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'Error inesperado: ${e.toString()}'));
    }
  }
}

class CreateProductRequest extends Equatable {
  final String name;
  final String description;
  final double price;
  final String category;
  final int stock;
  final String? imageUrl;

  const CreateProductRequest({
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.stock,
    this.imageUrl,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'price': price,
        'category': category,
        'stock': stock,
        if (imageUrl != null) 'imageUrl': imageUrl,
      };

  @override
  List<Object?> get props => [name, description, price, category, stock, imageUrl];
}