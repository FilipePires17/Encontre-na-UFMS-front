import 'package:fpdart/fpdart.dart';

import '../repos/i_location_repo.dart';

class SetRating {
  final ILocationRepo _repository;

  const SetRating(this._repository);

  Future<Either<Error, bool>> call(
      {required int id, required double rating}) async {
    return await _repository.setRating(id: id, rating: rating);
  }
}
