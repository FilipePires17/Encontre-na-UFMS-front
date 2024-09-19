import 'package:fpdart/fpdart.dart';

import '../entities/location_list_filter.dart';
import '../entities/location_list_item.dart';

abstract class ILocationListingRepo {
  Future<Either<Error, LocationList>> getLocationListingPaginated(
      {required LocationListFilter filter});

  Future<Either<Error, bool>> toggleFavoriteLocation({required int id});
}
