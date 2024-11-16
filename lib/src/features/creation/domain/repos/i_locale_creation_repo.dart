import 'package:fpdart/fpdart.dart';

import '../entities/locale_creation.dart';

abstract class ILocaleCreationRepo {
  Future<Either<dynamic, void>> createLocale(LocaleCreation localeCreation);

  Future<Either<dynamic, void>> updateLocale(LocaleCreation localeCreation);

  Future<Either<dynamic, LocaleCreation>> getLocale(int id);
}
