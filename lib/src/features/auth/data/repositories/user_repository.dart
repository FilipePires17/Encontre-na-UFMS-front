import 'package:fpdart/fpdart.dart';

import '../../../../core/platforms/network_info.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/i_user_repository.dart';
import '../data_sources/user_local_data_source.dart';
import '../data_sources/user_remote_data_source.dart';
// import '../dtos/user_dto.dart';

class UserRepository implements IUserRepository {
  final IUserRemoteDataSource remoteDataSource;
  final IUserLocalDataSource localDataSource;
  final INetworkInfo networkInfo;

  UserRepository({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  // @override
  // Future<Either<String, User>> getCurrentUser() async {
  //   if (await networkInfo.isConnected) {
  //     final response = await remoteDataSource.getCurrentUser();

  //     return response.match(
  //       (error) => Left(error),
  //       (res) => Right(UserDto.fromMap(res.data['entity'])),
  //     );
  //   } else {
  //     return const Left('Sem conexão');
  //   }
  // }

  @override
  Future<Either<Error, String?>> validateToken() async {
    if (await networkInfo.isConnected) {
      final isValid = await remoteDataSource.validateToken();

      return isValid.match((_) => Left(Error()), (res) async {
        if (res) {
          final token = await localDataSource.getCurrentUserToken();

          return token.match(
            (error) => Left(Error()),
            (token) => Right(token),
          );
        } else {
          return const Right(null);
        }
      });
    } else {
      return Left(Error());
    }
  }

  @override
  Future<Either<String, User>> signInUser({
    required String email,
    required String password,
  }) async {
    if (await networkInfo.isConnected) {
      final user = await remoteDataSource.signInUser(email, password);

      return user.match(
        (errorMessage) => Left(errorMessage),
        (res) {
          localDataSource.cacheToken(
            token: res.token,
            refreshToken: res.refreshToken,
          );
          return Right(res.toEntity());
        },
      );
    } else {
      return const Left('Sem conexão');
    }
  }

  @override
  Future<Either<dynamic, void>> changePassword(
      {required String newPassword}) async {
    if (await networkInfo.isConnected) {
      final response = await remoteDataSource.changePassword(newPassword);

      return response;
    } else {
      return const Left('Sem conexão');
    }
  }

  @override
  Future<Either<String, void>> signOutUser() async {
    final response = await localDataSource.deleteToken();

    return response;
  }

  @override
  Future<Either<dynamic, void>> sendVerificationEmail(
      {required String email}) async {
    if (await networkInfo.isConnected) {
      final response = await remoteDataSource.sendVerificationEmail(email);
      return response;
    } else {
      return const Left('Sem conexão');
    }
  }

  @override
  Future<Either<dynamic, void>> verifyRedefinitionCode(
      {required String email, required String code}) async {
    if (await networkInfo.isConnected) {
      final response =
          await remoteDataSource.verifyRedefinitionCode(email, code);

      response.match(
        (_) => null,
        (res) => localDataSource.cacheToken(token: res.data['message']),
      );

      return response;
    } else {
      return const Left('Sem conexão');
    }
  }

  @override
  Future<Either<String, User>> registerUser(
      {required String name,
      required String email,
      required String password}) async {
    if (await networkInfo.isConnected) {
      final user = await remoteDataSource.registerUser(
        name: name,
        email: email,
        password: password,
      );

      return user.match(
        (errorMessage) => Left(errorMessage),
        (res) {
          localDataSource.cacheToken(
            token: res.token,
            refreshToken: res.refreshToken,
          );
          return Right(res.toEntity());
        },
      );
    } else {
      return const Left('Sem conexão');
    }
  }

  @override
  Future<Either<dynamic, User>> editProfile(
      {String? name, String? password}) async {
    if (await networkInfo.isConnected) {
      final user = await remoteDataSource.editProfile(
        name: name,
        password: password,
      );

      return user.match(
        (errorMessage) => Left(errorMessage),
        (res) {
          return Right(res);
        },
      );
    } else {
      return const Left('Sem conexão');
    }
  }
}
