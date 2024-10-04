import 'package:fpdart/fpdart.dart';

import '../entities/sections.dart';
import '../enums/enum_sections.dart';
import '../repos/i_location_repo.dart';

class GetSection {
  final ILocationRepo repo;

  const GetSection({required this.repo});

  Future<Either<String, Section>> call(
      {required int id, required EnumSections section}) async {
    return await repo.getSection(id: id, section: section);
  }
}
