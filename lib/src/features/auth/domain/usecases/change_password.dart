import 'package:fpdart/fpdart.dart';

import '../repositories/i_user_repository.dart';

class ChangePassword {
  final IUserRepository repository;

  const ChangePassword({required this.repository});

  Future<Either<dynamic, void>> call({required String password}) async {
    return await repository.changePassword(newPassword: password);
  }
}
