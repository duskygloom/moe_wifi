const unhandledExceptionMessage = 'Encountered an unhandled exception.';
const noUserSelectedMessage = 'No default user selected.';

class KnownException implements Exception {
  KnownException(this.message);

  final String message;

  @override
  String toString() => message;
}
