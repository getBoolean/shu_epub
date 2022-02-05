class EpubException implements Exception {
  EpubException(this.message, [this.error, this.stackTrace]);

  final String message;
  final Exception? error;
  final StackTrace? stackTrace;
}
