part of 'auth_bloc.dart';

enum AuthStateStatus {
  loggedOff,
  onLoggedOff,
  loading,
  loggedIn,
  emailSent,
  validCode,
  loginError,
  emailError,
  error,
}

class AuthState extends Equatable {
  const AuthState({
    this.status = AuthStateStatus.loggedOff,
    this.user,
    this.errorMessage,
  });

  final AuthStateStatus status;
  final User? user;
  final String? errorMessage;

  AuthState copyWith({
    AuthStateStatus? status,
    User? user,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        user,
        errorMessage,
      ];
}
