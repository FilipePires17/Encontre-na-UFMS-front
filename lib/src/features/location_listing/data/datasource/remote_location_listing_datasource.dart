import 'package:fpdart/fpdart.dart';

import '../dtos/location_listing_dto.dart';

abstract class IRemoteLocationListingDatasource {
  Future<Either<Error, List<LocationListItemDto>>>
      getLocationListingPaginated();

  Future<Either<Error, List<LocationListItemDto>>>
      getLocationListingPaginatedByType(int type);

  Future<Either<Error, bool>> toggleFavoriteLocation(int id);
}

class RemoteLocationListingDatasource
    implements IRemoteLocationListingDatasource {
  @override
  Future<Either<Error, List<LocationListItemDto>>>
      getLocationListingPaginated() {
    // TODO: implement getLocationListingPaginated
    throw UnimplementedError();
  }

  @override
  Future<Either<Error, List<LocationListItemDto>>>
      getLocationListingPaginatedByType(int type) {
    // TODO: implement getLocationListingPaginatedByType
    throw UnimplementedError();
  }

  @override
  Future<Either<Error, bool>> toggleFavoriteLocation(int id) {
    // TODO: implement toggleFavoriteLocation
    throw UnimplementedError();
  }
}
