class ServerException implements Exception {}
class UnexpectedException implements Exception {
  final String message;

  UnexpectedException({required this.message});
}