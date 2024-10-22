import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common_widgets/custom_app_bar.dart';
import '../../../../core/constants/keys/route_names.dart';
import '../../../../core/constants/sizes/app_sizes.dart';
import '../../../../core/utils/app_validators.dart';
import '../bloc/auth/auth_bloc.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key, this.fromLocation});

  final bool? fromLocation;

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
        text: 'Criar nova senha',
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
                // controller: _passwordController,
                validator: (newPassword) =>
                    AppValidators.confirmPasswordValidator(
                  _passwordController.text,
                  newPassword,
                ),
              ),
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
                                    ChangePasswordEvent(
                                      password: _passwordController.text,
                                    ),
                                  );
                            }
                          },
                    child: state.status == AuthStateStatus.loading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : const Text('Alterar senha'),
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
