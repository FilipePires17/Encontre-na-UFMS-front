import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/common_widgets/custom_app_bar.dart';
import '../../../../core/constants/sizes/app_sizes.dart';
import '../cubit/creation_cubit.dart';
import '../widgets/image_picker_field.dart';

class LocationCreationScreen extends StatefulWidget {
  const LocationCreationScreen({super.key});

  @override
  State<LocationCreationScreen> createState() => _LocationCreationScreenState();
}

class _LocationCreationScreenState extends State<LocationCreationScreen> {
  late final CreationCubit creationCubit;
  GoogleMapController? mapController;
  Marker? _selectedMarker;
  final LatLng _initialPosition = const LatLng(
    -20.50246862307781,
    -54.61346732030084,
  );

  @override
  void initState() {
    creationCubit = BlocProvider.of<CreationCubit>(context);
    super.initState();
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
        child: Column(
          children: [
            const ImagePickerField(),
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
                  target: _initialPosition,
                  zoom: 15,
                ),
                minMaxZoomPreference: const MinMaxZoomPreference(16, 20),
                cameraTargetBounds: CameraTargetBounds(
                  LatLngBounds(
                    southwest:
                        const LatLng(-20.511849614479797, -54.6221641078335),
                    northeast:
                        const LatLng(-20.493427224405206, -54.60504801228526),
                  ),
                ),
                zoomControlsEnabled: false,
                onTap: (position) => setState(() {
                  _selectedMarker = Marker(
                    markerId: const MarkerId('selected_location'),
                    position: position,
                  );
                }),
                markers: _selectedMarker != null ? {_selectedMarker!} : {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
