import 'package:get_it/get_it.dart';

import '../../features/auth/data/data_sources/user_local_data_source.dart';
import '../../features/auth/data/data_sources/user_remote_data_source.dart';
import '../../features/auth/data/repositories/user_repository.dart';
import '../../features/auth/domain/repositories/i_user_repository.dart';
import '../../features/auth/domain/usecases/change_password.dart';
import '../../features/auth/domain/usecases/register_user.dart';
import '../../features/auth/domain/usecases/send_verification_email.dart';
import '../../features/auth/domain/usecases/sign_in_user.dart';
import '../../features/auth/domain/usecases/sign_out_user.dart';
import '../../features/auth/domain/usecases/validate_token.dart';
import '../../features/auth/domain/usecases/verify_redefinition_code.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/location/data/datasource/remote_location_datasource.dart';
import '../../features/location/data/repos/location_repo.dart';
import '../../features/location/domain/repos/i_location_repo.dart';
import '../../features/location/domain/usecases/get_location.dart';
import '../../features/location/domain/usecases/set_rating.dart';
import '../../features/location/presentation/bloc/location_bloc.dart';
import '../../features/location_listing/data/datasource/remote_location_listing_datasource.dart';
import '../../features/location_listing/data/repos/location_listing_repo.dart';
import '../../features/location_listing/domain/repos/i_location_listing_repo.dart';
import '../../features/location_listing/domain/usecases/get_location_listing_paginated.dart';
import '../../features/location_listing/domain/usecases/toggle_favorite_location.dart';
import '../../features/location_listing/presentation/bloc/location_listing_bloc.dart';
import '../../features/location_listing/presentation/cubit/location_categories_cubit.dart';
import '../../core/data/local/hive_manager.dart';
import '../../core/data/local/local_storage_manager.dart';
import '../../core/data/remote/http_manager.dart';
import '../../core/platforms/data_connection_checker.dart';
import '../../core/platforms/network_info.dart';

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

  sl.registerFactory(() => LocationCategoriesCubit());

  // Location
  sl.registerFactory(() => LocationBloc(
        getLocation: sl(),
        setRating: sl(),
      ));
  sl.registerLazySingleton(() => GetLocation(repo: sl()));
  sl.registerLazySingleton(() => SetRating(repo: sl()));
  sl.registerLazySingleton<ILocationRepo>(() => LocationRepo(
        remoteDataSource: sl(),
        networkInfo: sl(),
      ));
  sl.registerLazySingleton<IRemoteLocationDatasource>(
      () => RemoteLocationDatasource(httpClient: sl()));

  // Auth
  sl.registerFactory(() => AuthBloc(
        changePassword: sl(),
        sendVerificationEmail: sl(),
        signInUser: sl(),
        signOutUser: sl(),
        verifyRedefinitionCode: sl(),
        validateToken: sl(),
        registerUser: sl(),
      ));
  sl.registerLazySingleton(() => ChangePassword(repository: sl()));
  sl.registerLazySingleton(() => SendVerificationEmail(repository: sl()));
  sl.registerLazySingleton(() => SignInUser(repository: sl()));
  sl.registerLazySingleton(() => SignOutUser(repository: sl()));
  sl.registerLazySingleton(() => VerifyRedefinitionCode(repository: sl()));
  sl.registerLazySingleton(() => ValidateToken(repository: sl()));
  sl.registerLazySingleton(() => RegisterUser(repository: sl()));
  sl.registerLazySingleton<IUserRepository>(() => UserRepository(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
      ));
  sl.registerLazySingleton<IUserRemoteDataSource>(
      () => UserRemoteDataSource(httpClient: sl()));
  sl.registerLazySingleton<IUserLocalDataSource>(() => UserLocalDataSource(
        localStorageCaller: sl(),
      ));

  // Core
  sl.registerLazySingleton<INetworkInfo>(() => NetworkInfo(sl()));

  // External
  sl.registerLazySingleton(() => HttpManager());
  sl.registerLazySingleton(() => DataConnectionChecker());
  sl.registerLazySingleton<ILocalStorageCaller>(() => HiveLocalStorageCaller());
}
