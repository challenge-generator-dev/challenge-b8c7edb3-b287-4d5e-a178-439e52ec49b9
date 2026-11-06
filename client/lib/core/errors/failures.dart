package pedidos_app.core.errors;

import 'package:equatable/equatable.dart';

/// Clases para representar fallos en la aplicación usando el patrón Either.
/// Cada Failure corresponde a un tipo de error específico que puede ser manejado
/// de manera tipada en la capa de presentación.
abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  final int? statusCode;
  final String? errorCode;

  const ServerFailure({
    required String message,
    this.statusCode,
    this.errorCode,
  }) : super(message);

  @override
  List<Object?> get props => [message, statusCode, errorCode];
}

class NetworkFailure extends Failure {
  const NetworkFailure({String message = 'Error de conexión'})
      : super(message);
}

class CacheFailure extends Failure {
  const CacheFailure({String message = 'Error en caché'}) : super(message);
}

class ParseFailure extends Failure {
  const ParseFailure({String message = 'Error al parsear datos'})
      : super(message);
}

class AuthenticationFailure extends Failure {
  const AuthenticationFailure({String message = 'Error de autenticación'})
      : super(message);
}

class OfflineFailure extends Failure {
  const OfflineFailure({
    String message = 'No hay conexión y no hay datos en caché disponibles',
  }) : super(message);
}

/// Función de extensión para convertir excepciones en Failures
extension ExceptionToFailure on Exception {
  Failure toFailure() {
    if (this is ServerException) {
      final e = this as ServerException;
      return ServerFailure(
        message: e.message,
        statusCode: e.statusCode,
        errorCode: e.errorCode,
      );
    } else if (this is NetworkException) {
      return NetworkFailure(message: (this as NetworkException).message);
    } else if (this is CacheException) {
      return CacheFailure(message: (this as CacheException).message);
    } else if (this is ParseException) {
      return ParseFailure(message: (this as ParseException).message);
    } else if (this is AuthenticationException) {
      return AuthenticationFailure(message: (this as AuthenticationException).message);
    } else if (this is OfflineException) {
      return OfflineFailure(message: (this as OfflineException).message);
    } else {
      return Failure('Error desconocido');
    }
  }
}