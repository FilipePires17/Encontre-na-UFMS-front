import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/auth/presentation/bloc/auth/auth_bloc.dart';
import '../constants/keys/route_names.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    authBloc.add(const TokenValidationEvent());
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status != AuthStateStatus.loading) {
          Navigator.of(context).pushReplacementNamed(RouteNames.home);
        }
      },
      child: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
