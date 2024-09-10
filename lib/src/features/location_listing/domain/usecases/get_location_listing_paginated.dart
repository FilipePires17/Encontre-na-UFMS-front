import 'package:fpdart/fpdart.dart';

import '../entities/location_list_filter.dart';
import '../entities/location_list_item.dart';
import '../repos/i_location_listing_repo.dart';

class GetLocationListingPaginated {
  final ILocationListingRepo _locationListingRepo;

  const GetLocationListingPaginated(this._locationListingRepo);

  Future<Either<Error, List<LocationListItem>>> call(
      {required LocationListFilter filter}) async {
    return _locationListingRepo.getLocationListingPaginated(filter: filter);
  }
}
