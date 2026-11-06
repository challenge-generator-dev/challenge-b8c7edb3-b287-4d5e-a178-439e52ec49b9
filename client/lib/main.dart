import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pedidos_app/core/network/api_client.dart';
import 'package:pedidos_app/data/repositories/order_repository_impl.dart';
import 'package:pedidos_app/data/repositories/product_repository_impl.dart';
import 'package:pedidos_app/domain/repositories/order_repository.dart';
import 'package:pedidos_app/domain/repositories/product_repository.dart';
import 'package:pedidos_app/presentation/blocs/order/order_bloc.dart';
import 'package:pedidos_app/presentation/blocs/product/product_bloc.dart';
import 'package:pedidos_app/presentation/screens/orders_screen.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  // Network
  getIt.registerLazySingleton<ApiClient>(() => ApiClient());

  // Repositories
  getIt.registerLazySingleton<OrderRepository>(
    () => OrderRepositoryImpl(remoteDataSource: getIt()),
  );
  getIt.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(remoteDataSource: getIt()),
  );

  // BLoCs
  getIt.registerFactory<OrderBloc>(
    () => OrderBloc(orderRepository: getIt()),
  );
  getIt.registerFactory<ProductBloc>(
    () => ProductBloc(productRepository: getIt()),
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<OrderBloc>()..add(FetchOrders())),
        BlocProvider(create: (_) => getIt<ProductBloc>()..add(FetchProducts())),
      ],
      child: MaterialApp(
        title: 'Pedidos App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const OrdersScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}