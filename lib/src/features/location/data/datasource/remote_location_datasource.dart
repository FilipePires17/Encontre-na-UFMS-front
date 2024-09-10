import 'package:fpdart/fpdart.dart';

import '../dtos/location_dto.dart';

abstract class IRemoteLocationDatasource {
  Future<Either<Error, LocationDto>> getLocation({required int id});
  Future<Either<Error, bool>> toggleFavorite({required int id});
  Future<Either<Error, bool>> setRating(
      {required int id, required double rating});
}

class RemoteLocationDatasource implements IRemoteLocationDatasource {
  @override
  Future<Either<Error, LocationDto>> getLocation({required int id}) {
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
