import 'package:fpdart/fpdart.dart';

import '../../../../core/constants/api_urls.dart';
import '../../../../core/data/remote/http_manager.dart';
import '../../domain/entities/sections.dart';
import '../../domain/enums/enum_sections.dart';
import '../dtos/localization_section_dto.dart';
import '../dtos/location_dto.dart';

abstract class IRemoteLocationDatasource {
  Future<Either<String, LocationDto>> getLocation({required int id});
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
  Future<Either<String, LocationDto>> getLocation({required int id}) async {
    final response = await httpClient.restRequest(
      url: '${ApiUrls.locationSection}/$id',
      method: HttpMethods.get,
      parameters: {
        'sectionId': 0,
      },
    );

    if (response.statusCode != 200) {
      return left('Erro ao buscar local');
    }

    return right(LocationDto.fromMap(response.data['data']));
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
    final response = await httpClient.restRequest(
      url: '${ApiUrls.locationSection}/$id',
      method: HttpMethods.get,
      parameters: {
        'sectionId': section.index,
      },
    );

    if (response.statusCode != 200) {
      return left('Erro ao buscar seção');
    }

    return right(LocalizationSectionDto.fromMap(response.data['data']));
  }
}
