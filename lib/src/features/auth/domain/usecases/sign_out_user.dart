import 'package:fpdart/fpdart.dart';

import '../repositories/i_user_repository.dart';

class SignOutUser {
  final IUserRepository repository;
  const SignOutUser({required this.repository});

  Future<Either<Error, void>> call() async {
    return await repository.signOutUser();
  }
}
