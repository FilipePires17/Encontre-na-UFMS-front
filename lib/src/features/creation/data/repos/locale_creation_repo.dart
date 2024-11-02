import 'package:fpdart/fpdart.dart';

import '../../../../core/platforms/network_info.dart';
import '../../domain/entities/locale_creation.dart';
import '../../domain/repos/i_locale_creation_repo.dart';
import '../datasource/locale_creation_remote_datasource.dart';

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
    // TODO: implement createLocale
    throw UnimplementedError();
  }
}
