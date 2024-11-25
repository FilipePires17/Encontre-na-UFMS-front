import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common_widgets/custom_app_bar.dart';
import '../../../../core/constants/keys/route_names.dart';
import '../../../../core/constants/sizes/app_sizes.dart';
import '../../../../core/constants/theme/app_colors.dart';
import '../../../../core/utils/app_validators.dart';
import '../bloc/auth/auth_bloc.dart';
import '../bloc/profile/profile_bloc.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key, this.fromLocation, required this.email});

  final bool? fromLocation;
  final String email;

  @override
  State<NewPasswordScreen> createState() => CodeScreenState();
}

class CodeScreenState extends State<NewPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Criar nova senha',
        context: context,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.p16),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const Spacer(),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nova senha',
                ),
                controller: _passwordController,
                validator: AppValidators.passwordValidator,
              ),
              gapH8,
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Confirmar nova senha',
                ),
                validator: (newPassword) =>
                    AppValidators.confirmPasswordValidator(
                  _passwordController.text,
                  newPassword,
                ),
              ),
              const Spacer(),
              BlocConsumer<ProfileBloc, ProfileState>(
                listener: (context, state) {
                  switch (state.status) {
                    case ProfileStateStatus.error:
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.errorMessage!),
                        ),
                      );
                      break;
                    case ProfileStateStatus.loaded:
                      context
                          .read<AuthBloc>()
                          .add(UpdateUserEvent(user: state.user!));
                      if (widget.fromLocation == true) {
                        Navigator.of(context).popUntil(
                          (route) => route.settings.name == RouteNames.location,
                        );
                      } else {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          RouteNames.home,
                          (route) => false,
                        );
                      }
                      break;
                    default:
                      break;
                  }
                },
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: state.status == ProfileStateStatus.loading
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              context.read<ProfileBloc>().add(
                                    EditProfileEvent(
                                      email: widget.email,
                                      password: _passwordController.text,
                                    ),
                                  );
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                    ),
                    child: state.status == ProfileStateStatus.loading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : const Text(
                            'Alterar senha',
                            style: TextStyle(color: AppColors.white),
                          ),
                  );
                },
              ),
              gapH16,
            ],
          ),
        ),
      ),
    );
  }
}
