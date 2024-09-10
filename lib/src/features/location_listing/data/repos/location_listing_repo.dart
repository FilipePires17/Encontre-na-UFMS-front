import 'package:fpdart/fpdart.dart';

import '../../domain/entities/location_list_filter.dart';
import '../../domain/repos/i_location_listing_repo.dart';
import '../dtos/location_listing_dto.dart';

class LocationListingRepo implements ILocationListingRepo {
  @override
  Future<Either<Error, List<LocationListItemDto>>> getLocationListingPaginated(
      {required LocationListFilter filter}) {
    // TODO: implement getLocationListingPaginated
    throw UnimplementedError();
  }

  @override
  Future<Either<Error, bool>> toggleFavoriteLocation({required int id}) {
    // TODO: implement toggleFavoriteLocation
    throw UnimplementedError();
  }
}
