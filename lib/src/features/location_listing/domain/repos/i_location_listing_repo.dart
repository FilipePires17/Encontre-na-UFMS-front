import 'package:fpdart/fpdart.dart';

import '../entities/location_list_item.dart';

abstract class ILocationListingRepo {
  Future<Either<Error, List<LocationListItem>>> getLocationListingPaginated();

  Future<Either<Error, List<LocationListItem>>>
      getLocationListingPaginatedByType(int type);

  Future<Either<Error, bool>> toggleFavoriteLocation(int id);
}
