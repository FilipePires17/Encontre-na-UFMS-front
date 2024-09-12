import 'package:fpdart/fpdart.dart';

import '../repositories/i_user_repository.dart';

class VerifyRedefinitionCode {
  final IUserRepository repository;

  const VerifyRedefinitionCode({required this.repository});

  Future<Either<dynamic, void>> call(
      {required String email, required String code}) async {
    return await repository.verifyRedefinitionCode(email: email, code: code);
  }
}
