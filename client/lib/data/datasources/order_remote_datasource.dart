package pedidos_app.data.datasources;

import 'package:dio/dio.dart';
import 'package:pedidos_app/core/constants/api_constants.dart';
import 'package:pedidos_app/core/errors/exceptions.dart';
import 'package:pedidos_app/data/models/order_model.dart';

abstract class OrderRemoteDataSource {
  Future<List<OrderModel>> getOrders();
  Future<OrderModel> getOrderById(String id);
  Future<OrderModel> createOrder(CreateOrderRequestModel request);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final Dio dio;

  OrderRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<OrderModel>> getOrders() async {
    try {
      final url = ApiConstants.buildUrl(ApiConstants.ordersEndpoint);
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
            .map((json) => OrderModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw ServerException(
          message: 'Error al obtener pedidos',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      _handleDioError(e);
    }
    return [];
  }

  @override
  Future<OrderModel> getOrderById(String id) async {
    try {
      final url = ApiConstants.buildOrderByIdUrl(id);
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
        return OrderModel.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw ServerException(
          message: 'Error al obtener el pedido',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      _handleDioError(e);
    }
    throw ServerException(message: 'Error desconocido al obtener pedido');
  }

  @override
  Future<OrderModel> createOrder(CreateOrderRequestModel request) async {
    try {
      final url = ApiConstants.buildUrl(ApiConstants.ordersEndpoint);
      final response = await dio.post(
        url,
        data: request.toJson(),
        options: Options(
          sendTimeout: Duration(milliseconds: ApiConstants.connectTimeout),
          receiveTimeout: Duration(milliseconds: ApiConstants.receiveTimeout),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return OrderModel.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw ServerException(
          message: 'Error al crear el pedido',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      _handleDioError(e);
    }
    throw ServerException(message: 'Error desconocido al crear pedido');
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

class CreateOrderRequestModel {
  final String? customerId;
  final String customerName;
  final String customerEmail;
  final String customerPhone;
  final String deliveryAddress;
  final List<OrderItemModel> items;
  final String? notes;

  const CreateOrderRequestModel({
    this.customerId,
    required this.customerName,
    required this.customerEmail,
    required this.customerPhone,
    required this.deliveryAddress,
    required this.items,
    this.notes,
  });

  Map<String, dynamic> toJson() => {
        if (customerId != null) 'customerId': customerId,
        'customerName': customerName,
        'customerEmail': customerEmail,
        'customerPhone': customerPhone,
        'deliveryAddress': deliveryAddress,
        'items': items.map((item) => item.toJson()).toList(),
        if (notes != null) 'notes': notes,
      };
}

class OrderItemModel {
  final String productId;
  final String productName;
  final int quantity;
  final double unitPrice;
  final double? discount;

  const OrderItemModel({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
    this.discount,
  });

  Map<String, dynamic> toJson() => {
        'productId': productId,
        'productName': productName,
        'quantity': quantity,
        'unitPrice': unitPrice,
        if (discount != null) 'discount': discount,
      };
}