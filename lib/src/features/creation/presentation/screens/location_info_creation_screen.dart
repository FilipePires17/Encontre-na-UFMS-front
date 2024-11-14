import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common_widgets/custom_app_bar.dart';
import '../../../../core/common_widgets/custom_submit_button.dart';
import '../../../../core/common_widgets/custom_text_form_field.dart';
import '../../../../core/constants/sizes/app_sizes.dart';
import '../../../../core/constants/theme/app_colors.dart';
import '../../../../core/utils/app_validators.dart';
import '../../../location/domain/entities/sections.dart';
import '../../../location_listing/domain/enums/enum_location.dart';
import '../cubit/creation_cubit.dart';
import '../cubit/photos_cubit.dart';
import '../widgets/custom_selection_form_field.dart';
import '../widgets/image_picker_field.dart';

class LocationInfoCreationScreen extends StatefulWidget {
  const LocationInfoCreationScreen({super.key});

  @override
  State<LocationInfoCreationScreen> createState() =>
      _LocationInfoCreationScreenState();
}

class _LocationInfoCreationScreenState
    extends State<LocationInfoCreationScreen> {
  late final CreationCubit creationCubit;
  late final PhotosCubit photosCubit;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    creationCubit = BlocProvider.of<CreationCubit>(context);
    photosCubit = BlocProvider.of<PhotosCubit>(context);
    photosCubit.resetPhotos();
  }

  final scheduleControllers = List.generate(
    7,
    (index) => TextEditingController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        title: 'Mais Informações',
        fontSize: Sizes.p28,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.p16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      gapH12,
                      FormField(
                        builder: (state) {
                          return Column(
                            children: [
                              if (state.hasError)
                                Text(
                                  state.errorText.toString(),
                                  style: const TextStyle(
                                    color: AppColors.secondary,
                                    fontSize: Sizes.p12,
                                  ),
                                ),
                              const ImagePickerField(),
                            ],
                          );
                        },
                        validator: (_) {
                          if (photosCubit.state.isEmpty) {
                            return 'Adicione pelo menos uma foto';
                          }
                          return null;
                        },
                      ),
                      gapH24,
                      CustomTextFormField(
                        labelText: 'Nome',
                        isRequired: true,
                        validator: AppValidators.checkField,
                        onSaved: (value) {
                          creationCubit.setLocale(
                            creationCubit.state.locale.copyWith(name: value),
                          );
                        },
                      ),
                      gapH12,
                      CustomSelectionFormField(
                        title: 'Tipo *',
                        selectionOptions: EnumLocation.values,
                        onSaved: (value) {
                          creationCubit.setLocale(
                            creationCubit.state.locale.copyWith(
                              type: EnumLocation.values.firstWhere(
                                (element) => element.toString() == value,
                              ),
                            ),
                          );
                        },
                        validator: AppValidators.checkField,
                      ),
                      gapH12,
                      CustomTextFormField(
                        labelText: 'Telefone',
                        validator: AppValidators.phoneValidator,
                        onSaved: (value) {
                          creationCubit.setLocale(
                            creationCubit.state.locale.copyWith(phone: value),
                          );
                        },
                      ),
                      gapH12,
                      CustomTextFormField(
                        labelText: 'Sobre',
                        onSaved: (value) {
                          creationCubit.setLocale(
                            creationCubit.state.locale.copyWith(about: value),
                          );
                        },
                      ),
                      gapH12,
                      CustomTextFormField(
                        labelText: 'Observações',
                        onSaved: (value) {
                          creationCubit.setLocale(
                            creationCubit.state.locale
                                .copyWith(observation: value),
                          );
                        },
                      ),
                      gapH12,
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'Este local possui recursos de Acessibilidade?',
                            ),
                          ),
                          BlocBuilder<CreationCubit, CreationState>(
                            builder: (context, state) {
                              return Checkbox(
                                value: creationCubit
                                        .state.locale.hasAccessibility ??
                                    false,
                                onChanged: (value) {
                                  creationCubit.setLocale(
                                    creationCubit.state.locale.copyWith(
                                      hasAccessibility: value,
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                      gapH24,
                      const Text(
                        'Horários de Funcionamento',
                        style: TextStyle(
                          fontSize: Sizes.p16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      gapH12,
                      HourForm(
                        title: 'Segunda',
                        controller: scheduleControllers[0],
                        onSaved: (value) {
                          if (scheduleControllers[0].text.isEmpty) return;
                          if (value == null || value.isEmpty) return;
                          creationCubit.setLocale(
                            creationCubit.state.locale.copyWith(
                              hoursSection:
                                  (creationCubit.state.locale.hoursSection ??
                                          const HoursSection())
                                      .copyWith(
                                mondayHours:
                                    '${scheduleControllers[0].text} - $value',
                              ),
                            ),
                          );
                        },
                      ),
                      gapH12,
                      HourForm(
                        title: 'Terça',
                        controller: scheduleControllers[1],
                        onSaved: (value) {
                          if (scheduleControllers[1].text.isEmpty) return;
                          if (value == null || value.isEmpty) return;
                          creationCubit.setLocale(
                            creationCubit.state.locale.copyWith(
                              hoursSection:
                                  (creationCubit.state.locale.hoursSection ??
                                          const HoursSection())
                                      .copyWith(
                                tuesdayHours:
                                    '${scheduleControllers[1].text} - $value',
                              ),
                            ),
                          );
                        },
                      ),
                      gapH12,
                      HourForm(
                        title: 'Quarta',
                        controller: scheduleControllers[2],
                        onSaved: (value) {
                          if (scheduleControllers[2].text.isEmpty) return;
                          if (value == null || value.isEmpty) return;
                          creationCubit.setLocale(
                            creationCubit.state.locale.copyWith(
                              hoursSection:
                                  (creationCubit.state.locale.hoursSection ??
                                          const HoursSection())
                                      .copyWith(
                                wednesdayHours:
                                    '${scheduleControllers[2].text} - $value',
                              ),
                            ),
                          );
                        },
                      ),
                      gapH12,
                      HourForm(
                        title: 'Quinta',
                        controller: scheduleControllers[3],
                        onSaved: (value) {
                          if (scheduleControllers[3].text.isEmpty) return;
                          if (value == null || value.isEmpty) return;
                          creationCubit.setLocale(
                            creationCubit.state.locale.copyWith(
                              hoursSection:
                                  (creationCubit.state.locale.hoursSection ??
                                          const HoursSection())
                                      .copyWith(
                                thursdayHours:
                                    '${scheduleControllers[3].text} - $value',
                              ),
                            ),
                          );
                        },
                      ),
                      gapH12,
                      HourForm(
                        title: 'Sexta',
                        controller: scheduleControllers[4],
                        onSaved: (value) {
                          if (scheduleControllers[4].text.isEmpty) return;
                          if (value == null || value.isEmpty) return;
                          creationCubit.setLocale(
                            creationCubit.state.locale.copyWith(
                              hoursSection:
                                  (creationCubit.state.locale.hoursSection ??
                                          const HoursSection())
                                      .copyWith(
                                fridayHours:
                                    '${scheduleControllers[4].text} - $value',
                              ),
                            ),
                          );
                        },
                      ),
                      gapH12,
                      HourForm(
                        title: 'Sábado',
                        controller: scheduleControllers[5],
                        onSaved: (value) {
                          if (scheduleControllers[5].text.isEmpty) return;
                          if (value == null || value.isEmpty) return;
                          creationCubit.setLocale(
                            creationCubit.state.locale.copyWith(
                              hoursSection:
                                  (creationCubit.state.locale.hoursSection ??
                                          const HoursSection())
                                      .copyWith(
                                saturdayHours:
                                    '${scheduleControllers[5].text} - $value',
                              ),
                            ),
                          );
                        },
                      ),
                      gapH12,
                      HourForm(
                        title: 'Domingo',
                        controller: scheduleControllers[6],
                        onSaved: (value) {
                          if (scheduleControllers[6].text.isEmpty) return;
                          if (value == null || value.isEmpty) return;
                          creationCubit.setLocale(
                            creationCubit.state.locale.copyWith(
                              hoursSection:
                                  (creationCubit.state.locale.hoursSection ??
                                          const HoursSection())
                                      .copyWith(
                                sundayHours:
                                    '${scheduleControllers[6].text} - $value',
                              ),
                            ),
                          );
                        },
                      ),
                      gapH24,
                    ],
                  ),
                ),
              ),
            ),
            gapH24,
            BlocConsumer<CreationCubit, CreationState>(
              listener: (context, state) {
                if (state.status == CreationStateStatus.success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Sugestão enviada com sucesso!'),
                    ),
                  );
                  Navigator.popUntil(context, (route) => route.isFirst);
                } else if (state.status == CreationStateStatus.error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.errorMessage!),
                    ),
                  );
                }
              },
              builder: (context, state) {
                return CustomSubmitButton(
                  title: 'Enviar',
                  onPressed: state.status == CreationStateStatus.loading
                      ? null
                      : () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            creationCubit.setLocale(
                              creationCubit.state.locale.copyWith(
                                multimedia: photosCubit.state,
                              ),
                            );
                            creationCubit.create();
                          }
                        },
                );
              },
            ),
            gapH24,
          ],
        ),
      ),
    );
  }
}

class HourForm extends StatelessWidget {
  const HourForm({
    super.key,
    required this.title,
    this.onSaved,
    required this.controller,
  });

  final String title;
  final Function(String?)? onSaved;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title),
        gapW12,
        SizedBox(
          width: 92,
          child: CustomTextFormField(
            labelText: 'HH:MM',
            validator: AppValidators.hourValidator,
            controller: controller,
          ),
        ),
        gapW12,
        const Text('-'),
        gapW12,
        SizedBox(
          width: 92,
          child: CustomTextFormField(
            labelText: 'HH:MM',
            validator: AppValidators.hourValidator,
            onSaved: onSaved,
          ),
        ),
      ],
    );
  }
}
