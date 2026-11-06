package pedidos_app.data.datasources;

import 'package:dio/dio.dart';
import 'package:pedidos_app/core/constants/api_constants.dart';
import 'package:pedidos_app/core/errors/exceptions.dart';
import 'package:pedidos_app/data/models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
  Future<ProductModel> getProductById(String id);
  Future<List<ProductModel>> getProductsByCategory(String category);
  Future<ProductModel> searchProduct(String query);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Dio dio;

  ProductRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final url = ApiConstants.buildUrl(ApiConstants.productsEndpoint);
      final response = await dio.get(
        url,
        options: Options(
          sendTimeout: Duration(milliseconds: ApiConstants.connectTimeout),
          receiveTimeout: Duration(milliseconds: ApiConstants.receiveTimeout),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List<dynamic>;
        return data
            .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw ServerException(
          message: 'Error al obtener productos',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      _handleDioError(e);
    }
    return [];
  }

  @override
  Future<ProductModel> getProductById(String id) async {
    try {
      final url = '${ApiConstants.buildUrl(ApiConstants.productsEndpoint)}/$id';
      final response = await dio.get(
        url,
        options: Options(
          sendTimeout: Duration(milliseconds: ApiConstants.connectTimeout),
          receiveTimeout: Duration(milliseconds: ApiConstants.receiveTimeout),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return ProductModel.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw ServerException(
          message: 'Error al obtener el producto',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      _handleDioError(e);
    }
    throw ServerException(message: 'Error desconocido al obtener producto');
  }

  @override
  Future<List<ProductModel>> getProductsByCategory(String category) async {
    try {
      final url = ApiConstants.buildUrl('${ApiConstants.productsEndpoint}/category/$category');
      final response = await dio.get(
        url,
        options: Options(
          sendTimeout: Duration(milliseconds: ApiConstants.connectTimeout),
          receiveTimeout: Duration(milliseconds: ApiConstants.receiveTimeout),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List<dynamic>;
        return data
            .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw ServerException(
          message: 'Error al obtener productos por categoría',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      _handleDioError(e);
    }
    return [];
  }

  @override
  Future<ProductModel> searchProduct(String query) async {
    try {
      final url = ApiConstants.buildUrl('${ApiConstants.productsEndpoint}/search');
      final response = await dio.get(
        url,
        queryParameters: {'q': query},
        options: Options(
          sendTimeout: Duration(milliseconds: ApiConstants.connectTimeout),
          receiveTimeout: Duration(milliseconds: ApiConstants.receiveTimeout),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return ProductModel.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw ServerException(
          message: 'Error al buscar producto',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      _handleDioError(e);
    }
    throw ServerException(message: 'Error desconocido al buscar producto');
  }

  Never _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw NetworkException(
          message: 'Tiempo de conexión agotado',
          underlyingError: e.message,
        );
      case DioExceptionType.connectionError:
        throw OfflineException(
          message: 'Sin conexión a internet',
        );
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final data = e.response?.data;
        String message = 'Error del servidor';
        String? errorCode;

        if (data is Map<String, dynamic>) {
          message = data['message'] as String? ?? message;
          errorCode = data['errorCode'] as String?;
        }

        if (statusCode == 401) {
          throw AuthenticationException(message: message);
        }

        throw ServerException(
          message: message,
          statusCode: statusCode,
          errorCode: errorCode,
        );
      case DioExceptionType.cancel:
        throw ServerException(message: 'Solicitud cancelada');
      default:
        throw ServerException(
          message: e.message ?? 'Error de red desconocido',
        );
    }
  }
}