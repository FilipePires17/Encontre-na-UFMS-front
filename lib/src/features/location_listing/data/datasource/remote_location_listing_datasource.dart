import 'package:fpdart/fpdart.dart';

import '../../../../core/constants/api_urls.dart';
import '../../../../core/data/remote/http_manager.dart';
import '../dtos/location_list_filter_dto.dart';
import '../dtos/location_list_dto.dart';

abstract class IRemoteLocationListingDatasource {
  Future<Either<Error, LocationListDto>> getLocationListingPaginated(
      {required LocationListFilterDto filter});

  Future<Either<Error, bool>> toggleFavoriteLocation({required int id});
}

class RemoteLocationListingDatasource
    implements IRemoteLocationListingDatasource {
  const RemoteLocationListingDatasource({required this.httpClient});

  final HttpManager httpClient;

  @override
  Future<Either<Error, LocationListDto>> getLocationListingPaginated(
      {required LocationListFilterDto filter}) async {
    final response = await httpClient.restRequest(
      url: '${ApiUrls.baseLocations}/${filter.types.join(',')}',
      method: HttpMethods.get,
      parameters: filter.toMap(),
    );

    if (response.statusCode != 200) {
      return Left(Error());
    }

    return Right(LocationListDto.fromMap(response.data['data']));
  }

  @override
  Future<Either<Error, bool>> toggleFavoriteLocation({required int id}) async {
    final response = await httpClient.restRequest(
      url: '${ApiUrls.toggleFavorite}/$id',
      method: HttpMethods.post,
    );

    if (response.statusCode != 200 &&
        response.statusCode != 201 &&
        response.statusCode != 401) {
      return Left(Error());
    }

    if (response.statusCode == 401) {
      return const Right(false);
    } else {
      return const Right(true);
    }
  }
}
