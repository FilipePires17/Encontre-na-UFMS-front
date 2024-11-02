import 'package:fpdart/fpdart.dart';

import '../entities/locale_creation.dart';
import '../repos/i_locale_creation_repo.dart';

class CreateLocale {
  final ILocaleCreationRepo repo;

  const CreateLocale({required this.repo});

  Future<Either<dynamic, void>> call(LocaleCreation location) async {
    return await repo.createLocale(location);
  }
}
