import 'package:fpdart/fpdart.dart';

import '../../../../core/platforms/network_info.dart';
import '../../domain/entities/locale_creation.dart';
import '../../domain/repos/i_locale_creation_repo.dart';
import '../datasource/locale_creation_remote_datasource.dart';
import '../dtos/locale_creation_dto.dart';

class LocaleCreationRepo implements ILocaleCreationRepo {
  const LocaleCreationRepo({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  final ILocaleCreationRemoteDatasource remoteDataSource;
  final INetworkInfo networkInfo;

  @override
  Future<Either<dynamic, void>> createLocale(
      LocaleCreation localeCreation) async {
    if (await networkInfo.isConnected) {
      return remoteDataSource
          .createLocale(LocaleCreationDto.fromEntity(localeCreation));
    } else {
      return const Left('Sem conexão com a internet');
    }
  }

  @override
  Future<Either<dynamic, void>> updateLocale(
      LocaleCreation localeCreation) async {
    if (await networkInfo.isConnected) {
      return remoteDataSource
          .updateLocale(LocaleCreationDto.fromEntity(localeCreation));
    } else {
      return const Left('Sem conexão com a internet');
    }
  }

  @override
  Future<Either<dynamic, LocaleCreation>> getLocale(int id) async {
    if (await networkInfo.isConnected) {
      final result = await remoteDataSource.getLocale(id);
      return result.fold(
        (error) => Left(error),
        (locale) => Right(locale),
      );
    } else {
      return const Left('Sem conexão com a internet');
    }
  }
}
