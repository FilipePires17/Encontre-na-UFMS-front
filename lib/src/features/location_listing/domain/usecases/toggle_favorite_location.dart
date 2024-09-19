import 'package:fpdart/fpdart.dart';

import '../repos/i_location_listing_repo.dart';

class ToggleFavoriteLocation {
  final ILocationListingRepo repo;

  const ToggleFavoriteLocation({required this.repo});

  Future<Either<Error, bool>> call({required int id}) async {
    return repo.toggleFavoriteLocation(id: id);
  }
}
