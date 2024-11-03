import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common_widgets/custom_app_bar.dart';
import '../../../../core/constants/keys/route_names.dart';
import '../../../../core/constants/sizes/app_sizes.dart';
import '../../../../core/constants/theme/app_colors.dart';
import '../bloc/auth/auth_bloc.dart';
import '../widgets/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, this.fromLocation = false});

  final bool? fromLocation;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool obscureText = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'LOGIN',
        context: context,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.p16),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const Spacer(),
              CustomTextFormField(
                controller: _emailController,
                labelText: 'Email',
              ),
              gapH12,
              CustomTextFormField(
                controller: _passwordController,
                labelText: 'Senha',
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                  icon: obscureText
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off),
                ),
                obscureText: obscureText,
              ),
              gapH8,
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      RouteNames.emailSubmit,
                      arguments: widget.fromLocation,
                    );
                  },
                  child: const Text(
                    'Esqueci minha senha',
                    style: TextStyle(color: AppColors.secondary),
                  ),
                ),
              ),
              const Spacer(),
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state.status == AuthStateStatus.error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.errorMessage!),
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
                                    LoginEvent(
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
                        ? const CircularProgressIndicator()
                        : const Text(
                            'Entrar',
                            style: TextStyle(color: AppColors.white),
                          ),
                  );
                },
              ),
              gapH8,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('Não tem uma conta?'),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        RouteNames.register,
                      );
                    },
                    child: const Text(
                      'Crie uma conta',
                      style: TextStyle(color: AppColors.secondary),
                    ),
                  ),
                ],
              ),
              gapH16,
            ],
          ),
        ),
      ),
    );
  }
}
