import 'package:fpdart/fpdart.dart';

import '../entities/user.dart';

abstract class IUserRepository {
  Future<Either<String, User>> getCurrentUser();
  Future<Either<Error, bool>> validateToken();
  Future<Either<Error, String>> signInUser(
      {required String email, required String password});
  Future<Either<dynamic, void>> changePassword({required String newPassword});
  Future<Either<Error, void>> signOutUser();
  Future<Either<dynamic, void>> sendVerificationEmail({required String email});
  Future<Either<dynamic, void>> verifyRedefinitionCode(
      {required String email, required String code});
}
