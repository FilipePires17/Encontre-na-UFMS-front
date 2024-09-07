import 'package:fpdart/fpdart.dart';

import '../entities/location_list_item.dart';
import '../repos/i_location_listing_repo.dart';

class GetLocationListingPaginatedByType {
  final ILocationListingRepo _locationListingRepository;

  const GetLocationListingPaginatedByType(this._locationListingRepository);

  Future<Either<Error, List<LocationListItem>>> call(int type) async {
    return _locationListingRepository.getLocationListingPaginatedByType(type);
  }
}
