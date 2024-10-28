import 'package:fpdart/fpdart.dart';

import '../entities/user.dart';
import '../repositories/i_user_repository.dart';

class EditProfile {
  final IUserRepository repository;

  const EditProfile({required this.repository});

  Future<Either<dynamic, User>> call(
      {String? name, required String email, String? password}) async {
    return await repository.editProfile(
      name: name,
      email: email,
      password: password,
    );
  }
}
