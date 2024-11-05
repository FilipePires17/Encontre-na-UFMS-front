import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common_widgets/custom_app_bar.dart';
import '../../../../core/constants/keys/route_names.dart';
import '../../../../core/constants/sizes/app_sizes.dart';
import '../../../../core/constants/theme/app_colors.dart';
import '../../../../core/utils/app_validators.dart';
import '../bloc/auth/auth_bloc.dart';
import '../../../../core/common_widgets/custom_text_form_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, this.fromLocation});

  final bool? fromLocation;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Criar Nova Conta',
        context: context,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.p16),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              gapH16,
              // const Spacer(),
              // TextFormField(
              //   decoration: const InputDecoration(
              //     labelText: 'Nome',
              //   ),
              //   controller: _nameController,
              //   validator: AppValidators.checkField,
              // ),
              CustomTextFormField(
                controller: _nameController,
                labelText: 'Nome',
              ),
              gapH12,
              // TextFormField(
              //   decoration: const InputDecoration(
              //     labelText: 'Email',
              //   ),
              //   controller: _emailController,
              //   validator: AppValidators.emailValidator,
              // ),
              CustomTextFormField(
                controller: _emailController,
                labelText: 'Email',
              ),
              gapH12,
              // TextFormField(
              //   decoration: const InputDecoration(
              //     labelText: 'Senha',
              //   ),
              //   controller: _passwordController,
              //   validator: AppValidators.passwordValidator,
              // ),
              CustomTextFormField(
                controller: _passwordController,
                labelText: 'Senha',
                obscureText: true,
              ),
              gapH12,
              // TextFormField(
              //   decoration: const InputDecoration(
              //     labelText: 'Confirmar Senha',
              //   ),
              //   validator: (passwordConfirmation) {
              //     return AppValidators.confirmPasswordValidator(
              //       _passwordController.text,
              //       passwordConfirmation,
              //     );
              //   },
              // ),
              CustomTextFormField(
                labelText: 'Confirmar Senha',
                obscureText: true,
                validator: (passwordConfirmation) {
                  return AppValidators.confirmPasswordValidator(
                    _passwordController.text,
                    passwordConfirmation,
                  );
                },
              ),
              gapH16,
              const Spacer(),
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state.status == AuthStateStatus.loginError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.errorMessage!),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else if (state.status == AuthStateStatus.loggedIn) {
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
                  }
                },
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: state.status == AuthStateStatus.loading
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthBloc>().add(
                                    RegisterEvent(
                                      name: _nameController.text,
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                    ),
                                  );
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                    ),
                    child: state.status == AuthStateStatus.loading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : const Text(
                            'Criar Conta',
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
