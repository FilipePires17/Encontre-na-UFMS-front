import 'package:fpdart/fpdart.dart';

import '../repos/i_location_repo.dart';

class ToggleFavorite {
  final ILocationRepo _repository;

  const ToggleFavorite(this._repository);

  Future<Either<Error, bool>> call({required int id}) async {
    return await _repository.toggleFavorite(id: id);
  }
}
