package pedidos_app.presentation.blocs.order;

import 'package:equatable/equatable.dart';
import 'package:pedidos_app/domain/entities/order.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object?> get props => [];
}

class LoadOrdersEvent extends OrderEvent {
  const LoadOrdersEvent();
}

class LoadOrderByIdEvent extends OrderEvent {
  final String orderId;

  const LoadOrderByIdEvent(this.orderId);

  @override
  List<Object?> get props => [orderId];
}

class CreateOrderEvent extends OrderEvent {
  final Order order;

  const CreateOrderEvent(this.order);

  @override
  List<Object?> get props => [order];
}

class RefreshOrdersEvent extends OrderEvent {
  const RefreshOrdersEvent();
}

class ClearOrderErrorEvent extends OrderEvent {
  const ClearOrderErrorEvent();
}
"// === ARCHIVO: lib/presentation/blocs/order/order_state.dart ===
package pedidos_app.presentation.blocs.order;

import 'package:equatable/equatable.dart';
import 'package:pedidos_app/core/errors/failures.dart';
import 'package:pedidos_app/domain/entities/order.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object?> get props => [];
}

class OrderInitial extends OrderState {
  const OrderInitial();
}

class OrderLoading extends OrderState {
  const OrderLoading();
}

class OrdersLoaded extends OrderState {
  final List<Order> orders;
  final DateTime loadedAt;

  const OrdersLoaded({
    required this.orders,
    required this.loadedAt,
  });

  @override
  List<Object?> get props => [orders, loadedAt];
}

class OrderDetailLoaded extends OrderState {
  final Order order;

  const OrderDetailLoaded(this.order);

  @override
  List<Object?> get props => [order];
}

class OrderCreated extends OrderState {
  final Order order;

  const OrderCreated(this.order);

  @override
  List<Object?> get props => [order];
}

class OrderError extends OrderState {
  final String message;
  final Failure failure;

  const OrderError({
    required this.message,
    required this.failure,
  });

  @override
  List<Object?> get props => [message, failure];
}

class OrderOperationInProgress extends OrderState {
  final String operation;

  const OrderOperationInProgress(this.operation);

  @override
  List<Object?> get props => [operation];
}
"// === ARCHIVO: lib/presentation/blocs/order/order_bloc.dart ===
package pedidos_app.presentation.blocs.order;

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pedidos_app/core/errors/exceptions.dart';
import 'package:pedidos_app/core/errors/failures.dart';
import 'package:pedidos_app/domain/entities/order.dart';
import 'package:pedidos_app/domain/repositories/order_repository.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository orderRepository;

  OrderBloc({required this.orderRepository}) : super(const OrderInitial()) {
    on<LoadOrdersEvent>(_onLoadOrders);
    on<LoadOrderByIdEvent>(_onLoadOrderById);
    on<CreateOrderEvent>(_onCreateOrder);
    on<RefreshOrdersEvent>(_onRefreshOrders);
    on<ClearOrderErrorEvent>(_onClearError);
  }

  Future<void> _onLoadOrders(
    LoadOrdersEvent event,
    Emitter<OrderState> emit,
  ) async {
    emit(const OrderLoading());
    try {
      final result = await orderRepository.getOrders();
      result.fold(
        (failure) => emit(OrderError(
          message: failure.message,
          failure: failure,
        )),
        (orders) => emit(OrdersLoaded(
          orders: orders,
          loadedAt: DateTime.now(),
        )),
      );
    } on ServerException catch (e) {
      emit(OrderError(
        message: e.message,
        failure: e.toFailure(),
      ));
    } on NetworkException catch (e) {
      emit(OrderError(
        message: e.message,
        failure: e.toFailure(),
      ));
    } on OfflineException catch (e) {
      emit(OrderError(
        message: e.message,
        failure: e.toFailure(),
      ));
    } catch (e) {
      emit(OrderError(
        message: 'Error inesperado al cargar pedidos: ${e.toString()}',
        failure: const ServerFailure(message: 'Error inesperado'),
      ));
    }
  }

  Future<void> _onLoadOrderById(
    LoadOrderByIdEvent event,
    Emitter<OrderState> emit,
  ) async {
    emit(const OrderLoading());
    try {
      final result = await orderRepository.getOrderById(event.orderId);
      result.fold(
        (failure) => emit(OrderError(
          message: failure.message,
          failure: failure,
        )),
        (order) => emit(OrderDetailLoaded(order)),
      );
    } on ServerException catch (e) {
      emit(OrderError(
        message: e.message,
        failure: e.toFailure(),
      ));
    } on NetworkException catch (e) {
      emit(OrderError(
        message: e.message,
        failure: e.toFailure(),
      ));
    } on OfflineException catch (e) {
      emit(OrderError(
        message: e.message,
        failure: e.toFailure(),
      ));
    } catch (e) {
      emit(OrderError(
        message: 'Error inesperado al cargar el pedido: ${e.toString()}',
        failure: const ServerFailure(message: 'Error inesperado'),
      ));
    }
  }

  Future<void> _onCreateOrder(
    CreateOrderEvent event,
    Emitter<OrderState> emit,
  ) async {
    emit(const OrderOperationInProgress('Creando pedido...'));
    try {
      final result = await orderRepository.createOrder(event.order);
      result.fold(
        (failure) => emit(OrderError(
          message: failure.message,
          failure: failure,
        )),
        (order) => emit(OrderCreated(order)),
      );
    } on ServerException catch (e) {
      emit(OrderError(
        message: e.message,
        failure: e.toFailure(),
      ));
    } on NetworkException catch (e) {
      emit(OrderError(
        message: e.message,
        failure: e.toFailure(),
      ));
    } on OfflineException catch (e) {
      emit(OrderError(
        message: e.message,
        failure: e.toFailure(),
      ));
    } catch (e) {
      emit(OrderError(
        message: 'Error inesperado al crear el pedido: ${e.toString()}',
        failure: const ServerFailure(message: 'Error inesperado'),
      ));
    }
  }

  Future<void> _onRefreshOrders(
    RefreshOrdersEvent event,
    Emitter<OrderState> emit,
  ) async {
    try {
      final result = await orderRepository.getOrders();
      result.fold(
        (failure) => emit(OrderError(
          message: failure.message,
          failure: failure,
        )),
        (orders) => emit(OrdersLoaded(
          orders: orders,
          loadedAt: DateTime.now(),
        )),
      );
    } on ServerException catch (e) {
      emit(OrderError(
        message: e.message,
        failure: e.toFailure(),
      ));
    } on NetworkException catch (e) {
      emit(OrderError(
        message: e.message,
        failure: e.toFailure(),
      ));
    } catch (e) {
      emit(OrderError(
        message: 'Error al actualizar pedidos: ${e.toString()}',
        failure: const ServerFailure(message: 'Error inesperado'),
      ));
    }
  }

  void _onClearError(
    ClearOrderErrorEvent event,
    Emitter<OrderState> emit,
  ) {
    emit(const OrderInitial());
  }
}