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
  final _confirmPasswordController = TextEditingController();

  late AuthBloc authBloc;
  late ProfileBloc profileBloc;

  @override
  void initState() {
    super.initState();
    authBloc = BlocProvider.of<AuthBloc>(context);
    profileBloc = BlocProvider.of<ProfileBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Perfil',
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
                  labelText: 'Email',
                ),
                initialValue: authBloc.state.user!.email,
                enabled: false,
              ),
              gapH12,
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nova Senha (opcional)',
                ),
                controller: _passwordController,
                onChanged: (_) => setState(() {}),
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
                controller: _confirmPasswordController,
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
                      authBloc.add(UpdateUserEvent(user: state.user!));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Alterações feitas com sucesso!'),
                        ),
                      );
                      _passwordController.clear();
                      _confirmPasswordController.clear();
                      break;
                    default:
                      break;
                  }
                },
                builder: (context, state) => ElevatedButton(
                  onPressed: state.status == ProfileStateStatus.loading
                      ? null
                      : () {
                          if (_formKey.currentState!.validate()) {
                            profileBloc.add(
                              EditProfileEvent(
                                name: _nameController.text,
                                email: authBloc.state.user!.email,
                                password: _passwordController.text.isEmpty
                                    ? null
                                    : _passwordController.text,
                              ),
                            );
                          }
                        },
                  child: state.status == ProfileStateStatus.loading
                      ? const CircularProgressIndicator()
                      : const Text('Atualizar'),
                ),
              ),
              gapH16,
            ],
          ),
        ),
      ),
    );
  }
}
