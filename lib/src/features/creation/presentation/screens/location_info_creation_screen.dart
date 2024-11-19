import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common_widgets/custom_app_bar.dart';
import '../../../../core/common_widgets/custom_submit_button.dart';
import '../../../../core/common_widgets/custom_text_form_field.dart';
import '../../../../core/constants/sizes/app_sizes.dart';
import '../../../../core/constants/theme/app_colors.dart';
import '../../../../core/utils/app_masks.dart';
import '../../../../core/utils/app_validators.dart';
import '../../../location/domain/entities/sections.dart';
import '../../../location/domain/entities/special_info.dart';
import '../../../location_listing/domain/enums/enum_location.dart';
import '../../domain/entities/locale_creation.dart';
import '../cubit/creation_cubit.dart';
import '../cubit/photos_cubit.dart';
import '../widgets/custom_selection_form_field.dart';
import '../widgets/hour_form.dart';
import '../widgets/image_picker_field.dart';
import '../../../../core/utils/string_extension.dart';

class LocationInfoCreationScreen extends StatefulWidget {
  const LocationInfoCreationScreen({super.key, this.location});

  final LocaleCreation? location;

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
    if (widget.location != null) {
      creationCubit.setLocale(
        creationCubit.state.locale.copyWith(
          type: widget.location!.type,
        ),
      );
    }

    photosCubit = BlocProvider.of<PhotosCubit>(context);
    photosCubit.resetPhotos();
    for (final photo in widget.location?.multimedia ?? const []) {
      photosCubit.addPhoto(photo);
    }
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
                        initialValue: widget.location?.name,
                      ),
                      gapH12,
                      CustomSelectionFormField(
                        title: 'Tipo *',
                        selectionOptions: EnumLocation.values,
                        onSelected: (value) {
                          creationCubit.setLocale(
                            creationCubit.state.locale.copyWith(
                              type: EnumLocation.values.firstWhere(
                                (element) => element.toString() == value,
                              ),
                            ),
                          );
                          return;
                        },
                        validator: AppValidators.checkField,
                        initialValue: widget.location?.type.toString(),
                      ),
                      gapH12,
                      BlocBuilder<CreationCubit, CreationState>(
                        builder: (context, state) {
                          switch (state.locale.type) {
                            case EnumLocation.academicBlocks:
                              return CustomTextFormField(
                                labelText: 'Cursos Oferecidos',
                                onSaved: (value) {
                                  creationCubit.setLocale(
                                    creationCubit.state.locale.copyWith(
                                      specialInfo: (creationCubit
                                                  .state.locale.specialInfo ??
                                              const SpecialInfo())
                                          .copyWith(course: value),
                                    ),
                                  );
                                },
                                initialValue:
                                    widget.location?.specialInfo?.course,
                              );
                            case EnumLocation.libraries:
                              return CustomTextFormField(
                                labelText: 'Site da Biblioteca',
                                onSaved: (value) {
                                  creationCubit.setLocale(
                                    creationCubit.state.locale.copyWith(
                                      specialInfo: (creationCubit
                                                  .state.locale.specialInfo ??
                                              const SpecialInfo())
                                          .copyWith(libraryLink: value),
                                    ),
                                  );
                                },
                                initialValue:
                                    widget.location?.specialInfo?.libraryLink,
                              );
                            case EnumLocation.sportsCenters:
                              return CustomTextFormField(
                                labelText: 'Modalidades Oferecidas',
                                onSaved: (value) {
                                  creationCubit.setLocale(
                                    creationCubit.state.locale.copyWith(
                                      specialInfo: (creationCubit
                                                  .state.locale.specialInfo ??
                                              const SpecialInfo())
                                          .copyWith(availableSports: value),
                                    ),
                                  );
                                },
                                initialValue: widget
                                    .location?.specialInfo?.availableSports,
                              );
                            case EnumLocation.transports:
                              return CustomTextFormField(
                                labelText: 'Linhas de Ônibus',
                                onSaved: (value) {
                                  creationCubit.setLocale(
                                    creationCubit.state.locale.copyWith(
                                      specialInfo: (creationCubit
                                                  .state.locale.specialInfo ??
                                              const SpecialInfo())
                                          .copyWith(availableBuses: value),
                                    ),
                                  );
                                },
                                initialValue: widget
                                    .location?.specialInfo?.availableBuses,
                              );
                            default:
                              return const SizedBox.shrink();
                          }
                        },
                      ),
                      gapH12,
                      CustomTextFormField(
                        labelText: 'Telefone',
                        validator: AppValidators.phoneValidator,
                        inputFormatters: [AppMasks.phoneMask],
                        keyboardType: TextInputType.phone,
                        onSaved: (value) {
                          creationCubit.setLocale(
                            creationCubit.state.locale.copyWith(phone: value),
                          );
                        },
                        initialValue: widget.location?.phone?.phoneFormat(),
                      ),
                      gapH12,
                      CustomTextFormField(
                        labelText: 'Sobre',
                        onSaved: (value) {
                          creationCubit.setLocale(
                            creationCubit.state.locale.copyWith(about: value),
                          );
                        },
                        initialValue: widget.location?.about,
                        maxLines: 5,
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
                        initialValue: widget.location?.observation,
                        maxLines: 5,
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
                                    widget.location?.hasAccessibility ??
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
                        initialValue:
                            widget.location?.hoursSection?.mondayHours,
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
                        initialValue:
                            widget.location?.hoursSection?.tuesdayHours,
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
                        initialValue:
                            widget.location?.hoursSection?.wednesdayHours,
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
                        initialValue:
                            widget.location?.hoursSection?.thursdayHours,
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
                        initialValue:
                            widget.location?.hoursSection?.fridayHours,
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
                        initialValue:
                            widget.location?.hoursSection?.saturdayHours,
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
                        initialValue:
                            widget.location?.hoursSection?.sundayHours,
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
                if (state.status == CreationStateStatus.success ||
                    state.status == CreationStateStatus.updated) {
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
                            widget.location?.id != null
                                ? creationCubit.update()
                                : creationCubit.create();
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
