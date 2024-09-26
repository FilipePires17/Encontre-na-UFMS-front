import 'package:fpdart/fpdart.dart';

import '../entities/user.dart';
import '../repositories/i_user_repository.dart';

class RegisterUser {
  final IUserRepository repository;

  const RegisterUser({required this.repository});

  Future<Either<String, User>> call({
    required String name,
    required String email,
    required String password,
  }) async {
    return await repository.registerUser(
      name: name,
      email: email,
      password: password,
    );
  }
}
