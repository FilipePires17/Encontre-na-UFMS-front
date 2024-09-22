import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common_widgets/custom_app_bar.dart';
import '../../../../core/constants/keys/route_names.dart';
import '../../../../core/constants/sizes/app_sizes.dart';
import '../bloc/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
        text: 'LOGIN',
        context: context,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            const Spacer(),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
              controller: _emailController,
            ),
            gapH12,
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              controller: _passwordController,
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
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    RouteNames.home,
                    (route) => false,
                  );
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
                  child: state.status == AuthStateStatus.loading
                      ? const CircularProgressIndicator()
                      : const Text('Login'),
                );
              },
            ),
            gapH16,
          ],
        ),
      ),
    );
  }
}
