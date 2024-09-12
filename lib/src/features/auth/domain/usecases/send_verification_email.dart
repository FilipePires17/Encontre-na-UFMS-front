import 'package:fpdart/fpdart.dart';

import '../repositories/i_user_repository.dart';

class SendVerificationEmail {
  final IUserRepository repository;

  const SendVerificationEmail({required this.repository});

  Future<Either<dynamic, void>> call({required String email}) async {
    return await repository.sendVerificationEmail(email: email);
  }
}
