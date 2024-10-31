import 'package:fpdart/fpdart.dart';

import '../entities/location.dart';
import '../entities/sections.dart';
import '../enums/enum_sections.dart';

abstract class ILocationRepo {
  Future<Either<String, Location>> getLocation({required int id});

  Future<Either<String, Section>> getSection(
      {required int id, required EnumSections section});

  Future<Either<String, bool>> toggleFavorite({required int id});

  Future<Either<Error, bool>> setRating(
      {required int id, required double rating});

  Future<Either<String, bool>> deleteRating({required int id});

  Future<Either<String, double>> getUserRating({required int id});
}
