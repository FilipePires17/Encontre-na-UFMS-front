import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants/keys/route_names.dart';
import '../../core/presentation/splash_screen.dart';
import '../../core/services/injection_container.dart';
import '../../features/about/presentation/about_screen.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/location/presentation/screens/location_screen.dart';
import '../../features/location_listing/presentation/bloc/location_listing_bloc.dart';
import '../../features/location_listing/presentation/cubit/location_categories_cubit.dart';
import '../../features/location_listing/presentation/screens/location_listing_screen.dart';

class AppRouter {
  final _locationListingBloc = sl<LocationListingBloc>();
  final _locationCategoriesCubit = sl<LocationCategoriesCubit>();
  final _authBloc = sl<AuthBloc>();

  void dispose() {
    _locationListingBloc.close();
  }

  Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.home:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: _locationListingBloc,
              ),
              BlocProvider.value(
                value: _locationCategoriesCubit,
              ),
              BlocProvider.value(
                value: _authBloc,
              ),
            ],
            child: const LocationListingScreen(),
          ),
        );
      case RouteNames.location:
        return MaterialPageRoute(builder: (_) => const LocationScreen());
      case RouteNames.about:
        return MaterialPageRoute(builder: (_) => const AboutScreen());
      case RouteNames.login:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: _authBloc,
                  child: const LoginScreen(),
                ));
      default:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: _authBloc,
              ),
            ],
            child: const SplashScreen(),
          ),
        );
    }
  }
}
