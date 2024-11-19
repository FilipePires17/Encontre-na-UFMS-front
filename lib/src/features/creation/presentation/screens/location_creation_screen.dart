import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/common_widgets/custom_app_bar.dart';
import '../../../../core/common_widgets/custom_submit_button.dart';
import '../../../../core/constants/google_maps_constants.dart';
import '../../../../core/constants/keys/route_names.dart';
import '../../../../core/constants/sizes/app_sizes.dart';
import '../../../../core/constants/theme/app_colors.dart';
import '../../../../core/common_widgets/custom_text_form_field.dart';
import '../cubit/creation_cubit.dart';

class LocationCreationScreen extends StatefulWidget {
  const LocationCreationScreen({super.key, this.id});

  final int? id;

  @override
  State<LocationCreationScreen> createState() => _LocationCreationScreenState();
}

class _LocationCreationScreenState extends State<LocationCreationScreen> {
  late final CreationCubit creationCubit;
  GoogleMapController? mapController;
  Marker? selectedMarker;
  late LatLng initialPosition;
  final formKey = GlobalKey<FormState>();
  final addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    creationCubit = BlocProvider.of<CreationCubit>(context);
    creationCubit.reset();

    if (widget.id != null) {
      creationCubit.getLocation(widget.id!);
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreationCubit, CreationState>(
      builder: (context, state) {
        if (state.status == CreationStateStatus.loaded) {
          addressController.text = state.locale.address;
          selectedMarker = Marker(
            markerId: const MarkerId('selected_location'),
            position: LatLng(
              state.locale.latitude,
              state.locale.longitude,
            ),
          );
          initialPosition = LatLng(
            state.locale.latitude,
            state.locale.longitude,
          );
        } else {
          initialPosition = GoogleMapsConstants.facom;
        }
        return widget.id != null && state.status == CreationStateStatus.loading
            ? const Center(child: CircularProgressIndicator())
            : Scaffold(
                appBar: CustomAppBar(
                  context: context,
                  title: widget.id == null ? 'Adicionar Local' : 'Editar Local',
                ),
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Sizes.p16),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        const Spacer(),
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
                              zoom: GoogleMapsConstants.initialZoom,
                            ),
                            minMaxZoomPreference: const MinMaxZoomPreference(
                              GoogleMapsConstants.minZoom,
                              GoogleMapsConstants.maxZoom,
                            ),
                            cameraTargetBounds: CameraTargetBounds(
                              LatLngBounds(
                                southwest: GoogleMapsConstants.southwest,
                                northeast: GoogleMapsConstants.northeast,
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

                              List<Placemark> placemarks =
                                  await placemarkFromCoordinates(
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
                            markers:
                                selectedMarker != null ? {selectedMarker!} : {},
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
                        CustomTextFormField(
                          labelText: 'Endereço *',
                          onSaved: (value) {
                            creationCubit.setLocale(
                              creationCubit.state.locale
                                  .copyWith(address: value),
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
                        const Spacer(),
                        CustomSubmitButton(
                          title: 'Próximo',
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              Navigator.pushNamed(
                                context,
                                RouteNames.creationDetails,
                                arguments:
                                    widget.id != null ? state.locale : null,
                              );
                            }
                          },
                        ),
                        gapH12,
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }
}
