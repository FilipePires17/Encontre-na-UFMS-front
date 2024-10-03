import 'package:fpdart/fpdart.dart';

import '../../../../core/data/remote/http_manager.dart';
import '../../domain/entities/sections.dart';
import '../../domain/enums/enum_sections.dart';
import '../dtos/location_dto.dart';

abstract class IRemoteLocationDatasource {
  Future<Either<Error, LocationDto>> getLocation({required int id});
  Future<Either<String, Section>> getSection(
      {required int id, required EnumSections section});
  Future<Either<Error, bool>> toggleFavorite({required int id});
  Future<Either<Error, bool>> setRating(
      {required int id, required double rating});
}

class RemoteLocationDatasource implements IRemoteLocationDatasource {
  const RemoteLocationDatasource({required this.httpClient});

  final HttpManager httpClient;

  @override
  Future<Either<Error, LocationDto>> getLocation({required int id}) {
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

  @override
  Future<Either<String, Section>> getSection(
      {required int id, required EnumSections section}) {
    // TODO: implement getSection
    throw UnimplementedError();
  }
}
