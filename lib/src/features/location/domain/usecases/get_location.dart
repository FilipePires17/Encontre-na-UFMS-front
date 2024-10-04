import 'package:fpdart/fpdart.dart';

import '../entities/location.dart';
import '../repos/i_location_repo.dart';

class GetLocation {
  final ILocationRepo repo;

  const GetLocation({required this.repo});

  Future<Either<String, Location>> call({required int id}) async {
    return await repo.getLocation(id: id);
  }
}
