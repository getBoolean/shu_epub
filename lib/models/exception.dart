import 'package:equatable/equatable.dart';

class EpubException extends Equatable implements Exception {
  final String message;
  final Exception? error;
  final StackTrace? stackTrace;

  // GENERATED DO NOT MODOFY

  EpubException(this.message, [this.error, this.stackTrace]);

  EpubException copyWith({
    String? message,
    Exception? error,
    StackTrace? stackTrace,
  }) {
    return EpubException(
      message ?? this.message,
      error ?? this.error,
      stackTrace ?? this.stackTrace,
    );
  }

  @override
  String toString() => 'EpubException(message: $message, error: $error, stackTrace: $stackTrace)';

  @override
  List<Object> get props => [message, error ?? '', stackTrace ?? ''];
}
