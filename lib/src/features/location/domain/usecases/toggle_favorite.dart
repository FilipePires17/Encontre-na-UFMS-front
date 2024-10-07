import 'package:fpdart/fpdart.dart';

import '../repos/i_location_repo.dart';

class ToggleFavorite {
  final ILocationRepo repo;

  const ToggleFavorite({required this.repo});

  Future<Either<String, bool>> call({required int id}) async {
    return await repo.toggleFavorite(id: id);
  }
}
