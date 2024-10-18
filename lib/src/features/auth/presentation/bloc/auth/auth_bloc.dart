import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../../domain/entities/user.dart';
import '../../../domain/usecases/change_password.dart';
// import '../../domain/usecases/get_current_user.dart';
import '../../../domain/usecases/register_user.dart';
import '../../../domain/usecases/send_verification_email.dart';
import '../../../domain/usecases/sign_in_user.dart';
import '../../../domain/usecases/sign_out_user.dart';
import '../../../domain/usecases/validate_token.dart';
import '../../../domain/usecases/verify_redefinition_code.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final ChangePassword changePassword;
  // final GetCurrentUser getCurrentUser;
  final SendVerificationEmail sendVerificationEmail;
  final SignInUser signInUser;
  final SignOutUser signOutUser;
  final ValidateToken validateToken;
  final VerifyRedefinitionCode verifyRedefinitionCode;
  final RegisterUser registerUser;

  AuthBloc({
    required this.changePassword,
    // required this.getCurrentUser,
    required this.sendVerificationEmail,
    required this.signInUser,
    required this.signOutUser,
    required this.validateToken,
    required this.verifyRedefinitionCode,
    required this.registerUser,
  }) : super(const AuthState()) {
    on<LoginEvent>(
      (event, emit) async {
        emit(state.copyWith(status: AuthStateStatus.loading));

        await signInUser(
          email: event.email,
          password: event.password,
        ).then(
          (value) => value.fold(
            (errorMessage) {
              emit(state.copyWith(
                status: AuthStateStatus.error,
                errorMessage: errorMessage,
              ));
            },
            (user) {
              emit(state.copyWith(
                status: AuthStateStatus.loggedIn,
                user: user,
              ));
            },
          ),
        );
      },
    );

    on<TokenValidationEvent>(
      (event, emit) async {
        emit(state.copyWith(status: AuthStateStatus.loading));

        await validateToken().then(
          (value) => value.fold(
            (error) {
              add(LogoutEvent());
            },
            (token) {
              if (token != null) {
                final userInfo = JwtDecoder.decode(token);
                final user = User(
                  id: userInfo['id'].toString(),
                  name: userInfo['name'],
                  email: userInfo['email'],
                );
                emit(state.copyWith(
                  status: AuthStateStatus.loggedIn,
                  user: user,
                ));
              } else {
                add(LogoutEvent());
              }
            },
          ),
        );
      },
    );

    on<LogoutEvent>(
      (event, emit) async {
        emit(state.copyWith(status: AuthStateStatus.loading));

        await signOutUser().then(
          (value) => value.fold(
            (errorMessage) {
              emit(state.copyWith(
                status: AuthStateStatus.error,
                errorMessage: errorMessage,
              ));
              emit(state.copyWith(
                status: AuthStateStatus.loggedIn,
                errorMessage: errorMessage,
              ));
            },
            (_) {
              emit(state.copyWith(
                status: AuthStateStatus.onLoggedOff,
              ));
              emit(state.copyWith(
                status: AuthStateStatus.loggedOff,
              ));
            },
          ),
        );
      },
    );

    on<RegisterEvent>(
      (event, emit) async {
        emit(state.copyWith(status: AuthStateStatus.loading));

        await registerUser(
          email: event.email,
          password: event.password,
          name: event.name,
        ).then(
          (value) => value.fold(
            (errorMessage) {
              emit(state.copyWith(
                status: AuthStateStatus.error,
                errorMessage: errorMessage,
              ));
            },
            (user) {
              emit(state.copyWith(
                status: AuthStateStatus.loggedIn,
                user: user,
              ));
            },
          ),
        );
      },
    );

    on<UpdateUserEvent>(
      (event, emit) {
        emit(state.copyWith(user: event.user));
      },
    );
  }
}
