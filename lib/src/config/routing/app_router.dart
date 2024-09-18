import 'package:flutter/material.dart';

import '../../core/constants/keys/route_names.dart';
import '../../features/location/presentation/screens/location_screen.dart';
import '../../features/location_listing/presentation/screens/location_listing_screen.dart';

class AppRouter {
  Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.home:
        return MaterialPageRoute(builder: (_) => const LocationListingScreen());
      case RouteNames.location:
        return MaterialPageRoute(builder: (_) => const LocationScreen());
      default:
        return MaterialPageRoute(builder: (_) => const LocationListingScreen());
    }
  }
}
