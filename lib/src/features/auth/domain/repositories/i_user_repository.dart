import 'package:fpdart/fpdart.dart';

import '../entities/user.dart';

abstract class IUserRepository {
  // Future<Either<String, User>> getCurrentUser();
  Future<Either<Error, String?>> validateToken();
  Future<Either<String, User>> signInUser(
      {required String email, required String password});
  Future<Either<String, User>> registerUser({
    required String name,
    required String email,
    required String password,
  });
  // Future<Either<dynamic, bool>> refreshToken();
  Future<Either<dynamic, void>> changePassword({required String newPassword});
  Future<Either<String, void>> signOutUser();
  Future<Either<dynamic, void>> sendVerificationEmail({required String email});
  Future<Either<dynamic, void>> verifyRedefinitionCode(
      {required String email, required String code});
}
