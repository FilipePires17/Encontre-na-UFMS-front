import 'package:fpdart/fpdart.dart';

import '../repos/i_location_repo.dart';

class SetRating {
  final ILocationRepo repo;

  const SetRating({required this.repo});

  Future<Either<Error, bool>> call(
      {required int id, required double rating}) async {
    return await repo.setRating(id: id, rating: rating);
  }
}
