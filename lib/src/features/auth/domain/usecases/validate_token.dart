import 'package:fpdart/fpdart.dart';

import '../repositories/i_user_repository.dart';

class ValidateToken {
  final IUserRepository repository;

  ValidateToken({required this.repository});

  Future<Either<Error, bool>> call() async {
    return await repository.validateToken();
  }
}
