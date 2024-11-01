import 'package:fpdart/fpdart.dart';

import '../repos/i_location_repo.dart';

class GetUserRating {
  final ILocationRepo repo;

  GetUserRating({required this.repo});

  Future<Either<String, double>> call(int locationId) async {
    return repo.getUserRating(id: locationId);
  }
}
