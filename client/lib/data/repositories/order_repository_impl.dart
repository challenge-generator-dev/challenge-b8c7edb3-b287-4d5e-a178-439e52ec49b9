package pedidos_app.data.repositories;

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pedidos_app/core/constants/api_constants.dart';
import 'package:pedidos_app/core/errors/exceptions.dart';
import 'package:pedidos_app/core/errors/failures.dart';
import 'package:pedidos_app/data/datasources/order_remote_datasource.dart';
import 'package:pedidos_app/data/models/order_model.dart';
import 'package:pedidos_app/domain/entities/order.dart';
import 'package:pedidos_app/domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource remoteDataSource;

  const OrderRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Order>>> getOrders() async {
    try {
      final orderModels = await remoteDataSource.getOrders();
      final orders = orderModels.map(_mapModelToEntity).toList();
      return Right(orders);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
        statusCode: e.statusCode,
        errorCode: e.errorCode,
      ));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on OfflineException {
      return const Left(OfflineFailure());
    } on DioException catch (e) {
      return Left(_handleDioException(e));
    } catch (e) {
      return Left(ServerFailure(message: 'Error inesperado: $e'));
    }
  }

  @override
  Future<Either<Failure, Order>> getOrderById(String id) async {
    try {
      final orderModel = await remoteDataSource.getOrderById(id);
      final order = _mapModelToEntity(orderModel);
      return Right(order);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
        statusCode: e.statusCode,
        errorCode: e.errorCode,
      ));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on OfflineException {
      return const Left(OfflineFailure());
    } on DioException catch (e) {
      return Left(_handleDioException(e));
    } catch (e) {
      return Left(ServerFailure(message: 'Error inesperado: $e'));
    }
  }

  @override
  Future<Either<Failure, Order>> createOrder({
    required String customerId,
    required String customerName,
    required List<CreateOrderItemRequest> items,
    String? shippingAddress,
    String? notes,
  }) async {
    try {
      final createRequest = CreateOrderRequest(
        customerId: customerId,
        customerName: customerName,
        items: items,
        shippingAddress: shippingAddress,
        notes: notes,
      );
      final orderModel = await remoteDataSource.createOrder(createRequest);
      final order = _mapModelToEntity(orderModel);
      return Right(order);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
        statusCode: e.statusCode,
        errorCode: e.errorCode,
      ));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on OfflineException {
      return const Left(OfflineFailure());
    } on DioException catch (e) {
      return Left(_handleDioException(e));
    } catch (e) {
      return Left(ServerFailure(message: 'Error inesperado: $e'));
    }
  }

  Order _mapModelToEntity(OrderModel model) {
    return Order(
      id: model.id,
      customerId: model.customerId,
      customerName: model.customerName,
      status: _mapStatus(model.status),
      items: model.items.map(_mapItemModelToEntity).toList(),
      totalAmount: model.totalAmount,
      currency: model.currency,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
      shippingAddress: model.shippingAddress,
      notes: model.notes,
    );
  }

  OrderItem _mapItemModelToEntity(OrderItemModel model) {
    return OrderItem(
      productId: model.productId,
      productName: model.productName,
      quantity: model.quantity,
      unitPrice: model.unitPrice,
      subtotal: model.subtotal,
    );
  }

  OrderStatus _mapStatus(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return OrderStatus.pending;
      case 'confirmed':
        return OrderStatus.confirmed;
      case 'processing':
        return OrderStatus.processing;
      case 'shipped':
        return OrderStatus.shipped;
      case 'delivered':
        return OrderStatus.delivered;
      case 'cancelled':
        return OrderStatus.cancelled;
      default:
        return OrderStatus.pending;
    }
  }

  Failure _handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkFailure(message: 'Tiempo de conexión agotado');
      case DioExceptionType.connectionError:
        return const NetworkFailure(message: 'Sin conexión a internet');
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final message = e.response?.data?['message'] as String? ??
            'Error del servidor';
        return ServerFailure(message: message, statusCode: statusCode);
      case DioExceptionType.cancel:
        return const ServerFailure(message: 'Solicitud cancelada');
      default:
        return ServerFailure(message: e.message ?? 'Error de red desconocido');
    }
  }
}