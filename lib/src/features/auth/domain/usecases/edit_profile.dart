import 'package:fpdart/fpdart.dart';

import '../entities/user.dart';
import '../repositories/i_user_repository.dart';

class EditProfile {
  final IUserRepository repository;

  const EditProfile({required this.repository});

  Future<Either<dynamic, User>> call({String? name, String? password}) async {
    return await repository.editProfile(name: name, password: password);
  }
}
