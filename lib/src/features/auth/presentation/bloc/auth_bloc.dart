import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/user.dart';
import '../../domain/usecases/change_password.dart';
// import '../../domain/usecases/get_current_user.dart';
import '../../domain/usecases/send_verification_email.dart';
import '../../domain/usecases/sign_in_user.dart';
import '../../domain/usecases/sign_out_user.dart';
// import '../../domain/usecases/validate_token.dart';
import '../../domain/usecases/verify_redefinition_code.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final ChangePassword changePassword;
  // final GetCurrentUser getCurrentUser;
  final SendVerificationEmail sendVerificationEmail;
  final SignInUser signInUser;
  final SignOutUser signOutUser;
  // final ValidateToken validateToken;
  final VerifyRedefinitionCode verifyRedefinitionCode;

  AuthBloc({
    required this.changePassword,
    // required this.getCurrentUser,
    required this.sendVerificationEmail,
    required this.signInUser,
    required this.signOutUser,
    // required this.validateToken,
    required this.verifyRedefinitionCode,
  }) : super(const AuthState()) {
    on<LoginEvent>(
      (event, emit) async {
        emit(state.copyWith(status: AuthStateStatus.loading));

        await signInUser(
          email: event.email,
          password: event.password,
        ).then((value) => value.fold(
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
            ));
      },
    );
  }
}
