import 'package:fpdart/fpdart.dart';

import '../../../../core/platforms/network_info.dart';
import '../../domain/entities/location.dart';

import '../../domain/repos/i_location_repo.dart';
import '../datasource/remote_location_datasource.dart';

class LocationRepo implements ILocationRepo {
  const LocationRepo({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  final IRemoteLocationDatasource remoteDataSource;
  final INetworkInfo networkInfo;

  @override
  Future<Either<Error, Location>> getLocation({required int id}) {
    // TODO: implement getLocation
    throw UnimplementedError();
  }

  @override
  Future<Either<Error, bool>> setRating(
      {required int id, required double rating}) {
    // TODO: implement setRating
    throw UnimplementedError();
  }

  @override
  Future<Either<Error, bool>> toggleFavorite({required int id}) {
    // TODO: implement toggleFavorite
    throw UnimplementedError();
  }
}
