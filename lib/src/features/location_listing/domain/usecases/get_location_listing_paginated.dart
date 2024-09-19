import 'package:fpdart/fpdart.dart';

import '../entities/location_list_filter.dart';
import '../entities/location_list_item.dart';
import '../repos/i_location_listing_repo.dart';

class GetLocationListingPaginated {
  final ILocationListingRepo repo;

  const GetLocationListingPaginated({required this.repo});

  Future<Either<Error, LocationList>> call(
      {required LocationListFilter filter}) async {
    return repo.getLocationListingPaginated(filter: filter);
  }
}
