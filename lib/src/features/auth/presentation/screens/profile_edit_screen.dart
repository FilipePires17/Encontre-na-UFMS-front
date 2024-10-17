import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common_widgets/custom_app_bar.dart';
import '../../../../core/constants/sizes/app_sizes.dart';
import '../../../../core/utils/app_validators.dart';
import '../bloc/auth/auth_bloc.dart';
import '../bloc/profile/profile_bloc.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();

  late AuthBloc authBloc;

  @override
  void initState() {
    super.initState();
    authBloc = BlocProvider.of<AuthBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: 'Perfil',
        context: context,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.p16),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const Spacer(),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  _nameController.text = state.user!.name;
                  return TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Nome',
                    ),
                    controller: _nameController,
                    validator: AppValidators.checkField,
                  );
                },
              ),
              gapH12,
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Senha (opcional)',
                ),
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return null;
                  }
                  return AppValidators.passwordValidator(value);
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Confirmar Senha',
                ),
                enabled: _passwordController.text.isNotEmpty,
                validator: (passwordConfirmation) {
                  return AppValidators.confirmPasswordValidator(
                    _passwordController.text,
                    passwordConfirmation,
                  );
                },
              ),
              gapH16,
              const Spacer(),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Voltar'),
                  ),
                  gapH12,
                  BlocConsumer<ProfileBloc, ProfileState>(
                    listener: (context, state) {
                      if (state.status == ProfileStateStatus.loaded) {
                        authBloc.add(UpdateUserEvent(user: state.user!));
                      }
                    },
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: state.status == ProfileStateStatus.loading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {}
                              },
                        child: state.status == ProfileStateStatus.loading
                            ? const CircularProgressIndicator()
                            : const Text('Login'),
                      );
                    },
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
