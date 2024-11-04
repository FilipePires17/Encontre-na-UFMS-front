import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/common_widgets/custom_app_bar.dart';
import '../../../../core/common_widgets/custom_submit_button.dart';
import '../../../../core/constants/sizes/app_sizes.dart';
import '../../../../core/constants/theme/app_colors.dart';
import '../../../../core/utils/app_validators.dart';
import '../../../../core/common_widgets/custom_text_form_field.dart';
import '../../../location_listing/domain/enums/enum_location.dart';
import '../cubit/creation_cubit.dart';
import '../cubit/photos_cubit.dart';
import '../widgets/custom_selection_form_field.dart';
import '../widgets/image_picker_field.dart';

class LocationCreationScreen extends StatefulWidget {
  const LocationCreationScreen({super.key});

  @override
  State<LocationCreationScreen> createState() => _LocationCreationScreenState();
}

class _LocationCreationScreenState extends State<LocationCreationScreen> {
  late final CreationCubit creationCubit;
  late final PhotosCubit photosCubit;
  GoogleMapController? mapController;
  Marker? selectedMarker;
  final LatLng initialPosition = const LatLng(
    -20.50246862307781,
    -54.61346732030084,
  );
  final formKey = GlobalKey<FormState>();
  final addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    creationCubit = BlocProvider.of<CreationCubit>(context);
    photosCubit = BlocProvider.of<PhotosCubit>(context);
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        title: 'Adicionar Local',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.p16),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              gapH12,
              Container(
                height: 200,
                width: MediaQuery.sizeOf(context).width * .8,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                clipBehavior: Clip.hardEdge,
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: initialPosition,
                    zoom: 15,
                  ),
                  minMaxZoomPreference: const MinMaxZoomPreference(15, 19),
                  cameraTargetBounds: CameraTargetBounds(
                    LatLngBounds(
                      southwest: const LatLng(
                        -20.511849614479797,
                        -54.6221641078335,
                      ),
                      northeast: const LatLng(
                        -20.493427224405206,
                        -54.60504801228526,
                      ),
                    ),
                  ),
                  zoomControlsEnabled: false,
                  onTap: (position) async {
                    setState(() {
                      selectedMarker = Marker(
                        markerId: const MarkerId('selected_location'),
                        position: position,
                      );
                    });

                    creationCubit.setLocale(
                      creationCubit.state.locale.copyWith(
                        latitude: position.latitude,
                        longitude: position.longitude,
                        localizationLink:
                            'https://www.google.com/maps/search/?api=1&'
                            'query=${position.latitude},${position.longitude}',
                      ),
                    );

                    List<Placemark> placemarks = await placemarkFromCoordinates(
                      position.latitude,
                      position.longitude,
                    );
                    if (placemarks.isNotEmpty) {
                      creationCubit.setLocale(
                        creationCubit.state.locale.copyWith(
                          address: placemarks.first.street,
                        ),
                      );
                      addressController.text =
                          placemarks.first.street ?? 'Sem endereço';
                    }
                  },
                  markers: selectedMarker != null ? {selectedMarker!} : {},
                ),
              ),
              const Text(
                'Toque no mapa para indicar a localização',
                style: TextStyle(
                  color: AppColors.secondary,
                  fontSize: Sizes.p12,
                ),
              ),
              gapH24,
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      gapH12,
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
                      ),
                      gapH12,
                      CustomTextFormField(
                        labelText: 'Endereço *',
                        onSaved: (value) {
                          creationCubit.setLocale(
                            creationCubit.state.locale.copyWith(address: value),
                          );
                        },
                        controller: addressController,
                        isEnabled: false,
                        validator: (address) {
                          if (address == null || address.isEmpty) {
                            return 'Marque o local no mapa para preencher o endereço';
                          }
                          return null;
                        },
                      ),
                      gapH48,
                      FormField(
                        builder: (_) => const ImagePickerField(),
                        validator: (_) {
                          if (photosCubit.state.isEmpty) {
                            return 'Adicione pelo menos uma foto';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              gapH12,
              BlocConsumer<CreationCubit, CreationState>(
                listener: (context, state) {
                  if (state.status == CreationStateStatus.success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Sugestão enviada com sucesso!'),
                      ),
                    );
                    Navigator.pop(context);
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
                              creationCubit.create();
                            }
                          },
                  );
                },
              ),
              gapH12,
            ],
          ),
        ),
      ),
    );
  }
}
