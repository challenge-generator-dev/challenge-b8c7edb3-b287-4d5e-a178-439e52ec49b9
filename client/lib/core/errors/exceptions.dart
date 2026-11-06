package pedidos_app.core.errors;

/// Excepciones personalizadas para manejo de errores en la aplicación.
/// Cada excepción representa un tipo específico de error que puede ocurrir
/// durante la ejecución de la app, especialmente en operaciones de red y parsing.
class ServerException implements Exception {
  final String message;
  final int? statusCode;
  final String? errorCode;

  const ServerException({
    this.message = 'Error en el servidor',
    this.statusCode,
    this.errorCode,
  });

  @override
  String toString() {
    return 'ServerException{message: $message, statusCode: $statusCode, errorCode: $errorCode}';
  }
}

class NetworkException implements Exception {
  final String message;
  final String? underlyingError;

  const NetworkException({
    this.message = 'Error de conexión',
    this.underlyingError,
  });

  @override
  String toString() {
    return 'NetworkException{message: $message, underlyingError: $underlyingError}';
  }
}

class CacheException implements Exception {
  final String message;

  const CacheException({this.message = 'Error en caché'});

  @override
  String toString() => 'CacheException{message: $message}';
}

class ParseException implements Exception {
  final String message;
  final dynamic source;
  final StackTrace? stackTrace;

  const ParseException({
    this.message = 'Error al parsear datos',
    this.source,
    this.stackTrace,
  });

  @override
  String toString() {
    return 'ParseException{message: $message, source: $source}';
  }
}

class AuthenticationException implements Exception {
  final String message;

  const AuthenticationException({this.message = 'Error de autenticación'});

  @override
  String toString() => 'AuthenticationException{message: $message}';
}

/// Excepción para cuando se intenta acceder a un recurso offline
/// pero no hay datos en caché disponibles
class OfflineException implements Exception {
  final String message;

  const OfflineException({
    this.message = 'No hay conexión y no hay datos en caché disponibles',
  });

  @override
  String toString() => 'OfflineException{message: $message}';
}