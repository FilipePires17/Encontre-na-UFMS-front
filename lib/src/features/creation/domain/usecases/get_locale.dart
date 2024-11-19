import 'package:fpdart/fpdart.dart';

import '../entities/locale_creation.dart';
import '../repos/i_locale_creation_repo.dart';

class GetLocale {
  final ILocaleCreationRepo repo;

  const GetLocale({required this.repo});

  Future<Either<dynamic, LocaleCreation>> call(int id) async {
    return await repo.getLocale(id);
  }
}
