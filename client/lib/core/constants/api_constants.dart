package pedidos_app.core.constants;

/// Constantes para la configuración de la API del backend de pedidos.
/// Incluye URLs base, endpoints y configuraciones de timeout y headers.
class ApiConstants {
  /// URL base del backend de pedidos
  static const String baseUrl = 'http://api.pedidos.example.com';

  /// Timeout para conexiones (en milisegundos)
  static const int connectTimeout = 5000;

  /// Timeout para recepción de datos (en milisegundos)
  static const int receiveTimeout = 10000;

  /// Headers comunes para todas las peticiones
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  /// Endpoints de la API
  static const String ordersEndpoint = '/orders';
  static const String productsEndpoint = '/products';

  /// Constructor privado para evitar instanciación
  ApiConstants._();

  /// Valida que la URL base no esté vacía y termine con '/'
  static String get validatedBaseUrl {
    if (baseUrl.isEmpty) {
      throw const FormatException('La URL base no puede estar vacía');
    }
    return baseUrl.endsWith('/') ? baseUrl : '$baseUrl/';
  }

  /// Construye la URL completa para un endpoint dado
  static String buildUrl(String endpoint) {
    if (endpoint.isEmpty) {
      throw const FormatException('El endpoint no puede estar vacío');
    }
    return '${validatedBaseUrl}${endpoint.startsWith('/') ? endpoint.substring(1) : endpoint}';
  }

  /// Construye la URL para obtener un pedido por ID
  static String buildOrderByIdUrl(String id) {
    if (id.isEmpty) {
      throw const FormatException('El ID del pedido no puede estar vacío');
    }
    return '${buildUrl(ordersEndpoint)}/$id';
  }
}