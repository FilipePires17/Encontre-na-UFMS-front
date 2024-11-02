import 'package:fpdart/fpdart.dart';

import '../../../../core/data/remote/http_manager.dart';
import '../../domain/entities/locale_creation.dart';

abstract class ILocaleCreationRemoteDatasource {
  Future<Either<dynamic, void>> createLocale(LocaleCreation localeCreation);
}

class LocaleCreationRemoteDatasource
    implements ILocaleCreationRemoteDatasource {
  const LocaleCreationRemoteDatasource({required this.httpClient});

  final HttpManager httpClient;

  @override
  Future<Either<dynamic, void>> createLocale(
      LocaleCreation localeCreation) async {
    // TODO: implement createLocale
    throw UnimplementedError();
  }
}
