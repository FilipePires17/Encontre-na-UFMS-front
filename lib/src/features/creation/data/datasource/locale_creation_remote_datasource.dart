import 'package:fpdart/fpdart.dart';

import '../../../../core/constants/api_urls.dart';
import '../../../../core/data/remote/http_manager.dart';
import '../dtos/locale_creation_dto.dart';

abstract class ILocaleCreationRemoteDatasource {
  Future<Either<dynamic, void>> createLocale(LocaleCreationDto localeCreation);
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
}
