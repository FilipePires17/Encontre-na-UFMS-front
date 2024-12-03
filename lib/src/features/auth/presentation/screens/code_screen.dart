import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common_widgets/custom_app_bar.dart';
import '../../../../core/constants/keys/route_names.dart';
import '../../../../core/constants/sizes/app_sizes.dart';
import '../../../../core/constants/theme/app_colors.dart';
import '../../../../core/utils/app_validators.dart';
import '../bloc/auth/auth_bloc.dart';

class CodeScreen extends StatefulWidget {
  const CodeScreen({super.key, this.fromLocation, required this.email});

  final bool? fromLocation;
  final String email;

  @override
  State<CodeScreen> createState() => CodeScreenState();
}

class CodeScreenState extends State<CodeScreen> {
  final _formKey = GlobalKey<FormState>();

  final _codeController = TextEditingController();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Inserir o código',
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
                  labelText: 'Código recebido por email',
                ),
                controller: _codeController,
                validator: AppValidators.checkField,
              ),
              const Spacer(),
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state.status == AuthStateStatus.error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.errorMessage!),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else if (state.status == AuthStateStatus.validCode) {
                    Navigator.of(context).pushNamed(
                      RouteNames.passwordRedefinition,
                      arguments: [widget.fromLocation, widget.email],
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
                                    VerifyCodeEvent(
                                      email: widget.email,
                                      code: _codeController.text,
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
                            'Verificar código',
                            style: TextStyle(color: Colors.white),
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
