import 'package:fpdart/fpdart.dart';

import '../../../../core/platforms/network_info.dart';
import '../../domain/entities/location_list_filter.dart';
import '../../domain/repos/i_location_listing_repo.dart';
import '../datasource/remote_location_listing_datasource.dart';
import '../dtos/location_list_filter_dto.dart';
import '../dtos/location_listing_dto.dart';

class LocationListingRepo implements ILocationListingRepo {
  const LocationListingRepo({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  final IRemoteLocationListingDatasource remoteDataSource;
  final INetworkInfo networkInfo;

  @override
  Future<Either<Error, LocationListItemDto>> getLocationListingPaginated(
      {required LocationListFilter filter}) async {
    if (await networkInfo.isConnected) {
      final response = await remoteDataSource.getLocationListingPaginated(
        filter: LocationListFilterDto.fromDomain(filter),
      );

      return response.match(
        (error) => Left(error),
        (res) => Right(res),
      );
    } else {
      return Left(Error());
    }
  }

  @override
  Future<Either<Error, bool>> toggleFavoriteLocation({required int id}) {
    // TODO: implement toggleFavoriteLocation
    throw UnimplementedError();
  }
}
