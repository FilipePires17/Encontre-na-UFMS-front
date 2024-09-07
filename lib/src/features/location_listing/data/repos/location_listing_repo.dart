import 'package:fpdart/fpdart.dart';

import '../../domain/repos/i_location_listing_repo.dart';
import '../dtos/location_listing_dto.dart';

class LocationListingRepo implements ILocationListingRepo {
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
