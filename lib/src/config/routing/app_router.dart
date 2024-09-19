import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants/keys/route_names.dart';
import '../../core/services/injection_container.dart';
import '../../features/location/presentation/screens/location_screen.dart';
import '../../features/location_listing/presentation/bloc/location_listing_bloc.dart';
import '../../features/location_listing/presentation/screens/location_listing_screen.dart';

class AppRouter {
  final _locationListingBloc = sl<LocationListingBloc>();

  void dispose() {
    _locationListingBloc.close();
  }

  Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.home:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _locationListingBloc,
            child: const LocationListingScreen(),
          ),
        );
      case RouteNames.location:
        return MaterialPageRoute(builder: (_) => const LocationScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _locationListingBloc,
            child: const LocationListingScreen(),
          ),
        );
    }
  }
}
