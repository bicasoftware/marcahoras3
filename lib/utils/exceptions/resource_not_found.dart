class ResourceNotFound implements Exception {
  final String cause;
  ResourceNotFound(this.cause);
}
