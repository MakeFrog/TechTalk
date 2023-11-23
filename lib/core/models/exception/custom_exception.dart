class CustomException implements Exception {
  CustomException({
    required this.code,
    required this.message,
  });

  final String code;
  final String message;
}
