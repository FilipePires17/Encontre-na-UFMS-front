import 'package:fpdart/fpdart.dart';

import '../../../../core/constants/keys/hive_keys.dart';
import '../../../../core/data/local/local_storage_manager.dart';

abstract class IUserLocalDataSource {
  Future<Either<Error, void>> cacheToken(
      {required String token, String? refreshToken});

  Future<Either<Error, String>> getCurrentUserToken();
  Future<Either<String, void>> deleteToken();
}

class UserLocalDataSource implements IUserLocalDataSource {
  final ILocalStorageCaller localStorageCaller;

  UserLocalDataSource({required this.localStorageCaller});

  @override
  Future<Either<Error, void>> cacheToken(
      {required String token, String? refreshToken}) {
    Future<Either<Error, void>> a = localStorageCaller.saveData(
      table: HiveBoxNames.users,
      key: HiveKeys.token,
      value: token,
    );

    if (refreshToken != null) {
      a = localStorageCaller.saveData(
        table: HiveBoxNames.users,
        key: HiveKeys.refreshToken,
        value: refreshToken,
      );
    }

    return a;
  }

  @override
  Future<Either<Error, String>> getCurrentUserToken() async {
    final token = await localStorageCaller.restoreData(
      table: HiveBoxNames.users,
      key: HiveKeys.token,
    );

    return token.match(
      (error) => Left(error),
      (token) => Right(token as String),
    );
  }

  @override
  Future<Either<String, void>> deleteToken() async {
    Either<String, bool> tokenResponse = await localStorageCaller.deleteKey(
      table: HiveBoxNames.users,
      key: HiveKeys.token,
    );

    if (tokenResponse is Right) {
      Either<String, void> refreshTokenResponse =
          tokenResponse.match((error) => Left(error), (didDelete) {
        if (didDelete) {
          return const Right(null);
        } else {
          return const Left('Não foi possível sair.');
        }
      });

      return refreshTokenResponse.match(
        (error) => Left(error),
        (_) => localStorageCaller.deleteKey(
          table: HiveBoxNames.users,
          key: HiveKeys.refreshToken,
        ),
      );
    }

    return tokenResponse;
  }
}
