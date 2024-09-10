import 'package:fpdart/fpdart.dart';

import '../../domain/entities/location_list_filter.dart';
import '../dtos/location_listing_dto.dart';

abstract class IRemoteLocationListingDatasource {
  Future<Either<Error, List<LocationListItemDto>>> getLocationListingPaginated(
      {required LocationListFilter filter});

  Future<Either<Error, bool>> toggleFavoriteLocation({required int id});
}

class RemoteLocationListingDatasource
    implements IRemoteLocationListingDatasource {
  @override
  Future<Either<Error, List<LocationListItemDto>>> getLocationListingPaginated(
      {required LocationListFilter filter}) {
    // TODO: implement getLocationListingPaginated
    throw UnimplementedError();
  }

  @override
  Future<Either<Error, bool>> toggleFavoriteLocation({required int id}) {
    // TODO: implement toggleFavoriteLocation
    throw UnimplementedError();
  }
}
