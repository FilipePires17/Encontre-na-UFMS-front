import 'package:fpdart/fpdart.dart';

import '../../../../core/constants/api_urls.dart';
import '../../../../core/data/remote/http_manager.dart';
import '../dtos/location_list_filter_dto.dart';
import '../dtos/location_listing_dto.dart';

abstract class IRemoteLocationListingDatasource {
  Future<Either<Error, LocationListItemDto>> getLocationListingPaginated(
      {required LocationListFilterDto filter});

  Future<Either<Error, bool>> toggleFavoriteLocation({required int id});
}

class RemoteLocationListingDatasource
    implements IRemoteLocationListingDatasource {
  const RemoteLocationListingDatasource({required this.httpClient});

  final HttpManager httpClient;

  @override
  Future<Either<Error, LocationListItemDto>> getLocationListingPaginated(
      {required LocationListFilterDto filter}) async {
    final response = await httpClient.restRequest(
      url: '${ApiUrls.locations}/${filter.types.join(',')}',
      method: HttpMethods.get,
      parameters: filter.toMap(),
    );

    if (response.statusCode != 200) {
      return left(Error());
    }

    return Right(LocationListItemDto.fromMap(response.data['data']));
  }

  @override
  Future<Either<Error, bool>> toggleFavoriteLocation({required int id}) {
    // TODO: implement toggleFavoriteLocation
    throw UnimplementedError();
  }
}
