import 'package:fpdart/fpdart.dart';

import '../repos/i_location_listing_repo.dart';

class ToggleFavoriteLocation {
  final ILocationListingRepo _locationListingRepository;

  const ToggleFavoriteLocation(this._locationListingRepository);

  Future<Either<Error, bool>> call(int id) async {
    return _locationListingRepository.toggleFavoriteLocation(id);
  }
}
