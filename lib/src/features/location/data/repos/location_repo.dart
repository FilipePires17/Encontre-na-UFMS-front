import 'package:fpdart/fpdart.dart';

import '../../domain/entities/location.dart';

import '../../domain/repos/i_location_repo.dart';

class LocationRepo implements ILocationRepo {
  @override
  Future<Either<Error, Location>> getLocation({required int id}) {
    // TODO: implement getLocation
    throw UnimplementedError();
  }

  @override
  Future<Either<Error, bool>> setRating(
      {required int id, required double rating}) {
    // TODO: implement setRating
    throw UnimplementedError();
  }

  @override
  Future<Either<Error, bool>> toggleFavorite({required int id}) {
    // TODO: implement toggleFavorite
    throw UnimplementedError();
  }
}
