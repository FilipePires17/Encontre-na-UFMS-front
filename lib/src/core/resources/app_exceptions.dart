abstract class AppExceptions implements Exception {
  final String message;

  AppExceptions({required this.message});

  @override
  String toString() => 'AppExceptions: $message';
}

class UnauthorizedException extends AppExceptions {
  UnauthorizedException({required super.message});
}
