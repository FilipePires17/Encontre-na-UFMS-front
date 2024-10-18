import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common_widgets/custom_submit_button.dart';
import '../../../../core/constants/keys/route_names.dart';
import '../../../../core/constants/sizes/app_sizes.dart';
import '../../../../core/constants/theme/app_colors.dart';
import '../../../../core/utils/string_extension.dart';
import '../../../auth/presentation/bloc/auth/auth_bloc.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key, required this.onLogout});

  final Function onLogout;

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + Sizes.p16,
              left: Sizes.p32,
            ),
            child: const Text(
              'Encontre na UFMS',
              textAlign: TextAlign.start,
              style: TextStyle(
                color: AppColors.white,
                fontSize: Sizes.p24,
              ),
            ),
          ),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return state.status == AuthStateStatus.loggedIn
                  ? Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: Sizes.p32),
                      child: Text(
                        'Olá, ${state.user!.name.capitalizeAll()}',
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: Sizes.p16,
                        ),
                      ),
                    )
                  : const SizedBox();
            },
          ),
          const Spacer(),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return state.status == AuthStateStatus.loggedIn
                  ? Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: Sizes.p32),
                      child: CustomSubmitButton(
                        title: 'Perfil',
                        onPressed: () {
                          Navigator.of(context).pushNamed(RouteNames.profile);
                        },
                      ),
                    )
                  : const SizedBox();
            },
          ),
          gapH16,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.p32),
            child: CustomSubmitButton(
              title: 'Sobre',
              onPressed: () {
                Navigator.of(context).pushNamed(RouteNames.about);
              },
            ),
          ),
          gapH32,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.p32),
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state.status == AuthStateStatus.onLoggedOff) {
                  Navigator.of(context).pop();
                  onLogout();
                }
              },
              builder: (context, state) {
                final isLoggedIn = state.status == AuthStateStatus.loggedIn;
                final isLoading = state.status == AuthStateStatus.loading;
                return CustomSubmitButton(
                  title: isLoggedIn ? 'Sair' : 'Entrar',
                  onPressed: isLoading
                      ? null
                      : () {
                          if (isLoggedIn) {
                            authBloc.add(LogoutEvent());
                          } else {
                            Navigator.of(context).pushNamed(RouteNames.login);
                          }
                        },
                  customColor: AppColors.secondary,
                );
              },
            ),
          ),
          gapH12,
        ],
      ),
    );
  }
}
