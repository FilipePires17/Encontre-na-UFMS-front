import 'package:fpdart/fpdart.dart';

import '../../../../core/constants/api_urls.dart';
import '../../../../core/data/remote/http_manager.dart';
import '../../../location/data/dtos/hours_section_dto.dart';
import '../../../location/data/dtos/special_info_dto.dart';
import '../../../location_listing/domain/enums/enum_location.dart';
import '../dtos/locale_creation_dto.dart';

abstract class ILocaleCreationRemoteDatasource {
  Future<Either<dynamic, void>> createLocale(LocaleCreationDto localeCreation);

  Future<Either<dynamic, void>> updateLocale(LocaleCreationDto localeCreation);

  Future<Either<dynamic, LocaleCreationDto>> getLocale(int id);
}

class LocaleCreationRemoteDatasource
    implements ILocaleCreationRemoteDatasource {
  const LocaleCreationRemoteDatasource({required this.httpClient});

  final HttpManager httpClient;

  @override
  Future<Either<dynamic, void>> createLocale(
      LocaleCreationDto localeCreation) async {
    final response = await httpClient.restRequest(
      url: ApiUrls.createLocale,
      method: HttpMethods.post,
      body: {'locale': localeCreation.toMap()},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return const Right(null);
    }
    return Left(response.data['message'] ?? 'Erro ao criar local');
  }

  @override
  Future<Either<dynamic, void>> updateLocale(
      LocaleCreationDto localeCreation) async {
    final response = await httpClient.restRequest(
      url: '${ApiUrls.updateLocale}/${localeCreation.id}',
      method: HttpMethods.put,
      body: {'locale': localeCreation.toMap()},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return const Right(null);
    }
    return Left(response.data['message'] ?? 'Erro ao atualizar local');
  }

  @override
  Future<Either<dynamic, LocaleCreationDto>> getLocale(int id) async {
    // final response = await httpClient.restRequest(
    //   // TODO: alterar para o endpoint correto
    //   url: '{ApiUrls.getLocale}/$id',
    //   method: HttpMethods.get,
    // );

    // if (response.statusCode == 200) {
    //   return Right(LocaleCreationDto.fromMap(response.data));
    // }
    // return Left(response.data['message'] ?? 'Erro ao buscar local');
    return const Right(LocaleCreationDto(
      id: 1,
      name: 'Local 1',
      address: 'Rua 1',
      latitude: -20.50246862307781,
      longitude: -54.61346732030084,
      localizationLink: 'https://www.google.com/maps',
      hoursSection: HoursSectionDto(fridayHours: '08:00 - 18:00'),
      phone: '67999999999',
      type: EnumLocation.academicBlocks,
      about: 'Sobre o local',
      observation: 'Observação',
      specialInfo: SpecialInfoDto(
        course: 'Curso',
      ),
      hasAccessibility: true,
    ));
  }
}
