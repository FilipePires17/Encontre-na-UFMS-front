import 'package:fpdart/fpdart.dart';

import '../../../../core/platforms/network_info.dart';
import '../../domain/entities/location.dart';

import '../../domain/entities/sections.dart';
import '../../domain/enums/enum_sections.dart';
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
  Future<Either<String, Location>> getLocation({required int id}) async {
    if (await networkInfo.isConnected) {
      final result = await remoteDataSource.getLocation(id: id);
      return result.fold(
        (error) => left(error),
        (location) => right(location),
      );
    } else {
      return left('Sem conexão com a internet');
    }
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

  @override
  Future<Either<String, Section>> getSection(
      {required int id, required EnumSections section}) async {
    if (await networkInfo.isConnected) {
      final result =
          await remoteDataSource.getSection(id: id, section: section);
      return result.fold(
        (error) => left(error),
        (section) => right(section),
      );
    } else {
      return left('Sem conexão com a internet');
    }
  }
}
