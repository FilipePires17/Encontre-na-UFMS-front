import 'package:get_it/get_it.dart';

import '../../features/location_listing/data/datasource/remote_location_listing_datasource.dart';
import '../../features/location_listing/data/repos/location_listing_repo.dart';
import '../../features/location_listing/domain/repos/i_location_listing_repo.dart';
import '../../features/location_listing/domain/usecases/get_location_listing_paginated.dart';
import '../../features/location_listing/domain/usecases/toggle_favorite_location.dart';
import '../../features/location_listing/presentation/bloc/location_listing_bloc.dart';
import '../data/remote/http_manager.dart';
import '../platforms/data_connection_checker.dart';
import '../platforms/network_info.dart';

final sl = GetIt.instance;

void init() {
  // Features

  // Location Listing
  sl.registerFactory(() => LocationListingBloc(
        getLocationListingPaginated: sl(),
        toggleFavoriteLocation: sl(),
      ));
  sl.registerLazySingleton(() => GetLocationListingPaginated(repo: sl()));
  sl.registerLazySingleton(() => ToggleFavoriteLocation(repo: sl()));
  sl.registerLazySingleton<ILocationListingRepo>(() => LocationListingRepo(
        remoteDataSource: sl(),
        networkInfo: sl(),
      ));
  sl.registerLazySingleton<IRemoteLocationListingDatasource>(
      () => RemoteLocationListingDatasource(httpClient: sl()));

  // Core
  sl.registerLazySingleton<INetworkInfo>(() => NetworkInfo(sl()));

  // External
  sl.registerLazySingleton(() => HttpManager());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
