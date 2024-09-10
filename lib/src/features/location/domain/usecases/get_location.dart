import 'package:fpdart/fpdart.dart';

import '../entities/location.dart';
import '../repos/i_location_repo.dart';

class GetLocation {
  final ILocationRepo _repository;

  const GetLocation(this._repository);

  Future<Either<Error, Location>> call({required int id}) async {
    return await _repository.getLocation(id: id);
  }
}
