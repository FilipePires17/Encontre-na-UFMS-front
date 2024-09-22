import 'package:fpdart/fpdart.dart';

import '../entities/user.dart';
import '../repositories/i_user_repository.dart';

class SignInUser {
  final IUserRepository repository;

  SignInUser({required this.repository});

  Future<Either<String, User>> call(
      {required String email, required String password}) async {
    return await repository.signInUser(email: email, password: password);
  }
}
