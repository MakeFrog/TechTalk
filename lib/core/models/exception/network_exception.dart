class NetworkException implements Exception {
  NetworkException({
    required this.code,
    required this.message,
  });

  final String code;
  final String message;
}
