import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common_widgets/custom_app_bar.dart';
import '../../../../core/constants/keys/route_names.dart';
import '../../../../core/constants/sizes/app_sizes.dart';
import '../../../../core/utils/app_validators.dart';
import '../bloc/auth/auth_bloc.dart';

class EmailScreen extends StatefulWidget {
  const EmailScreen({super.key, this.fromLocation});

  final bool? fromLocation;

  @override
  State<EmailScreen> createState() => EmailScreenState();
}

class EmailScreenState extends State<EmailScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: 'Recuperar senha',
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
                  labelText: 'Email',
                ),
                controller: _emailController,
                validator: AppValidators.emailValidator,
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
                    Navigator.of(context).pushNamed(RouteNames.insertCode);
                  }
                },
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: state.status == AuthStateStatus.loading
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthBloc>().add(
                                    SendEmailEvent(
                                      email: _emailController.text,
                                    ),
                                  );
                            }
                          },
                    child: state.status == AuthStateStatus.loading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : const Text('Enviar código por email'),
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
