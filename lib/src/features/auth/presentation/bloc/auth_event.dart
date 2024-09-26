part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;
  const LoginEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class RegisterEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;

  const RegisterEvent({
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [name, email, password];
}

class TokenValidationEvent extends AuthEvent {
  const TokenValidationEvent();
}

class ChangePasswordEvent extends AuthEvent {
  final String password;

  const ChangePasswordEvent({required this.password});

  @override
  List<Object> get props => [password];
}

class LogoutEvent extends AuthEvent {}

class SendEmailEvent extends AuthEvent {
  final String email;

  const SendEmailEvent({required this.email});

  @override
  List<Object> get props => [email];
}

class VerifyCodeEvent extends AuthEvent {
  final String code;

  const VerifyCodeEvent({required this.code});

  @override
  List<Object> get props => [code];
}

class ResetAuthEvent extends AuthEvent {}
