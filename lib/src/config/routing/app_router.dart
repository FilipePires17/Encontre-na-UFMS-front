import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants/keys/route_names.dart';
import '../../core/presentation/splash_screen.dart';
import '../../features/auth/presentation/bloc/profile/profile_bloc.dart';
import '../../features/auth/presentation/screens/code_screen.dart';
import '../../features/auth/presentation/screens/email_screen.dart';
import '../../features/auth/presentation/screens/new_password_screen.dart';
import '../../features/auth/presentation/screens/profile_edit_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/creation/domain/entities/locale_creation.dart';
import '../../features/creation/presentation/cubit/creation_cubit.dart';
import '../../features/creation/presentation/cubit/photos_cubit.dart';
import '../../features/creation/presentation/screens/location_creation_screen.dart';
import '../../features/creation/presentation/screens/location_info_creation_screen.dart';
import '../../features/location/presentation/bloc/location/location_bloc.dart';
import '../../features/location/presentation/bloc/section/section_bloc.dart';
import '../../features/location/presentation/cubit/review_cubit.dart';
import '../services/injection_container.dart';
import '../../features/about/presentation/about_screen.dart';
import '../../features/auth/presentation/bloc/auth/auth_bloc.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/location/presentation/screens/location_screen.dart';
import '../../features/location_listing/presentation/bloc/location_listing_bloc.dart';
import '../../features/location_listing/presentation/cubit/location_categories_cubit.dart';
import '../../features/location_listing/presentation/screens/location_listing_screen.dart';

class AppRouter {
  final _locationListingBloc = sl<LocationListingBloc>();
  final _locationCategoriesCubit = sl<LocationCategoriesCubit>();
  final _locationBloc = sl<LocationBloc>();
  final _authBloc = sl<AuthBloc>();
  final _sectionBloc = sl<SectionBloc>();
  final _profileBloc = sl<ProfileBloc>();
  final _reviewCubit = sl<ReviewCubit>();
  final _creationCubit = sl<CreationCubit>();
  final _photosCubit = sl<PhotosCubit>();

  void dispose() {
    _locationListingBloc.close();
    _locationCategoriesCubit.close();
    _locationBloc.close();
    _authBloc.close();
    _sectionBloc.close();
    _profileBloc.close();
    _reviewCubit.close();
    _creationCubit.close();
    _photosCubit.close();
  }

  Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      // Locations
      case RouteNames.home:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: _locationListingBloc),
              BlocProvider.value(value: _locationCategoriesCubit),
              BlocProvider.value(value: _authBloc),
            ],
            child: const LocationListingScreen(),
          ),
        );
      case RouteNames.location:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: _locationBloc),
              BlocProvider.value(value: _sectionBloc),
              BlocProvider.value(value: _reviewCubit),
              BlocProvider.value(value: _authBloc),
            ],
            child: LocationScreen(
              id: settings.arguments as int,
            ),
          ),
          settings: const RouteSettings(name: RouteNames.location),
        );
      // Creation
      case RouteNames.creation:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: _creationCubit,
              ),
            ],
            child: LocationCreationScreen(
              id: settings.arguments as int?,
            ),
          ),
        );
      case RouteNames.creationDetails:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: _creationCubit,
              ),
              BlocProvider.value(
                value: _photosCubit,
              ),
            ],
            child: LocationInfoCreationScreen(
              location: settings.arguments as LocaleCreation?,
            ),
          ),
        );

      // Auth
      case RouteNames.login:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _authBloc,
            child: LoginScreen(
              fromLocation: settings.arguments as bool?,
            ),
          ),
        );
      case RouteNames.register:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _authBloc,
            child: RegisterScreen(
              fromLocation: settings.arguments as bool?,
            ),
          ),
        );
      case RouteNames.profile:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: _profileBloc),
              BlocProvider.value(value: _authBloc),
            ],
            child: const ProfileEditScreen(),
          ),
        );
      case RouteNames.emailSubmit:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _authBloc,
            child: EmailScreen(
              fromLocation: settings.arguments as bool?,
            ),
          ),
        );
      case RouteNames.insertCode:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _authBloc,
            child: CodeScreen(
              fromLocation: (settings.arguments as List?)?[0] as bool?,
              email: (settings.arguments as List?)?[1] as String,
            ),
          ),
        );
      case RouteNames.passwordRedefinition:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: _authBloc,
              ),
              BlocProvider.value(
                value: _profileBloc,
              ),
            ],
            child: NewPasswordScreen(
              fromLocation: (settings.arguments as List?)?[0] as bool?,
              email: (settings.arguments as List?)?[1] as String,
            ),
          ),
        );

      // Misc
      case RouteNames.about:
        return MaterialPageRoute(builder: (_) => const AboutScreen());

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
