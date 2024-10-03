import 'package:fpdart/fpdart.dart';

import '../entities/location.dart';
import '../entities/sections.dart';
import '../enums/enum_sections.dart';

abstract class ILocationRepo {
  Future<Either<Error, Location>> getLocation({required int id});

  Future<Either<String, Section>> getSection(
      {required int id, required EnumSections section});

  Future<Either<Error, bool>> toggleFavorite({required int id});

  Future<Either<Error, bool>> setRating(
      {required int id, required double rating});
}
