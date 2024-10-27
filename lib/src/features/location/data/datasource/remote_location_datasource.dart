import 'package:fpdart/fpdart.dart';

import '../../../../core/constants/api_urls.dart';
import '../../../../core/data/remote/http_manager.dart';
import '../../domain/entities/sections.dart';
import '../../domain/enums/enum_sections.dart';
import '../dtos/hours_section_dto.dart';
import '../dtos/localization_section_dto.dart';
import '../dtos/location_dto.dart';
import '../dtos/more_info_section_dto.dart';

abstract class IRemoteLocationDatasource {
  Future<Either<String, LocationDto>> getLocation({required int id});
  Future<Either<String, Section>> getSection(
      {required int id, required EnumSections section});
  Future<Either<String, bool>> toggleFavorite({required int id});
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
      return const Left('Erro ao buscar local');
    }

    return Right(LocationDto.fromMap(response.data['data']));
  }

  @override
  Future<Either<Error, bool>> setRating(
      {required int id, required double rating}) {
    // TODO: implement setRating
    throw UnimplementedError();
  }

  @override
  Future<Either<String, bool>> toggleFavorite({required int id}) async {
    final response = await httpClient.restRequest(
      url: '${ApiUrls.toggleFavorite}/$id',
      method: HttpMethods.post,
    );

    if (response.statusCode != 200 &&
        response.statusCode != 201 &&
        response.statusCode != 401) {
      return Left(response.data['message']);
    }

    if (response.statusCode == 401) {
      return const Right(false);
    } else {
      return const Right(true);
    }
  }

  @override
  Future<Either<String, Section>> getSection(
      {required int id, required EnumSections section}) async {
    final response = await httpClient.restRequest(
      url: '${ApiUrls.locationSection}/$id',
      method: HttpMethods.get,
      parameters: {
        'sectionId': section.name,
      },
    );

    if (response.statusCode != 200) {
      return const Left('Erro ao buscar seção');
    }

    switch (section) {
      case EnumSections.hours:
        return Right(HoursSectionDto.fromMap(response.data['data']));
      case EnumSections.moreInfo:
        return Right(MoreInfoSectionDto.fromMap(response.data['data']));
      default:
        return Right(LocalizationSectionDto.fromMap(response.data['data']));
    }
  }
}
