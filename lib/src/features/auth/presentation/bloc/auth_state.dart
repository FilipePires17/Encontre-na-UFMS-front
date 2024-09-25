part of 'auth_bloc.dart';

enum AuthStateStatus {
  loggedOff,
  onLoggedOff,
  loading,
  loggedIn,
  firstAccess,
  emailSent,
  validCode,
  loginError,
  emailError,
  error,
}

class AuthState extends Equatable {
  const AuthState({
    this.status = AuthStateStatus.loggedOff,
    this.email,
    this.user,
    this.errorMessage,
  });

  final AuthStateStatus status;
  final String? email;
  final User? user;
  final String? errorMessage;

  AuthState copyWith({
    AuthStateStatus? status,
    String? email,
    User? user,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      email: email ?? this.email,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        email,
        user,
        errorMessage,
      ];
}
