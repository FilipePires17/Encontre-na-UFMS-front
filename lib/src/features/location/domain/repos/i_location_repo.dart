import 'package:fpdart/fpdart.dart';

import '../entities/location.dart';

abstract class ILocationRepo {
  Future<Either<Error, Location>> getLocation({required int id});

  Future<Either<Error, bool>> toggleFavorite({required int id});

  Future<Either<Error, bool>> setRating(
      {required int id, required double rating});
}
