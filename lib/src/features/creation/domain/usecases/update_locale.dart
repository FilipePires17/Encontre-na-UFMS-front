import 'package:fpdart/fpdart.dart';

import '../entities/locale_creation.dart';
import '../repos/i_locale_creation_repo.dart';

class UpdateLocale {
  final ILocaleCreationRepo repo;

  const UpdateLocale({required this.repo});

  Future<Either<dynamic, void>> call(LocaleCreation location) async {
    return await repo.updateLocale(location);
  }
}
