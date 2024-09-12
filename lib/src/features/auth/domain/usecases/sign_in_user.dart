import 'package:fpdart/fpdart.dart';

import '../repositories/i_user_repository.dart';

class SignInUser {
  final IUserRepository repository;

  SignInUser(this.repository);

  Future<Either<Error, String>> call(
      {required String email, required String password}) async {
    return await repository.signInUser(email: email, password: password);
  }
}
