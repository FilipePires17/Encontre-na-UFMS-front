import 'package:fpdart/fpdart.dart';

import '../../../../core/constants/keys/hive_keys.dart';
import '../../../../core/data/local/local_storage_manager.dart';

abstract class IUserLocalDataSource {
  Future<Either<Error, void>> cacheToken(String token);

  Future<Either<Error, String>> getCurrentUserToken();
  Future<Either<Error, void>> deleteToken();
}

class UserLocalDataSource implements IUserLocalDataSource {
  final ILocalStorageCaller localStorageCaller;

  UserLocalDataSource(this.localStorageCaller);

  @override
  Future<Either<Error, void>> cacheToken(String token) {
    return localStorageCaller.saveData(
      table: HiveBoxNames.users,
      key: HiveKeys.token,
      value: token,
    );
  }

  @override
  Future<Either<Error, String>> getCurrentUserToken() async {
    final token = await localStorageCaller.restoreData(
      table: HiveBoxNames.users,
      key: HiveKeys.token,
    );

    return token as Either<Error, String>;
  }

  @override
  Future<Either<Error, void>> deleteToken() async {
    final response = await localStorageCaller.deleteKey(
      table: HiveBoxNames.users,
      key: HiveKeys.token,
    );

    return response as Either<Error, void>;
  }
}
