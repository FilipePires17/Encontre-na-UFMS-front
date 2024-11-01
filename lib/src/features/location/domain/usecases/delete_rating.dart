import 'package:fpdart/fpdart.dart';

import '../repos/i_location_repo.dart';

class DeleteRating {
  final ILocationRepo repo;

  DeleteRating({required this.repo});

  Future<Either<String, void>> call(int locationId) async {
    return repo.deleteRating(id: locationId);
  }
}
