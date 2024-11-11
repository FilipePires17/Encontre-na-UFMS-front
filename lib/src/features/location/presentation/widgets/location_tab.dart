import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/sizes/app_sizes.dart';
import '../../../../core/constants/theme/app_colors.dart';
import '../../../auth/presentation/bloc/auth/auth_bloc.dart';
import '../../domain/entities/sections.dart';
import 'review_section.dart';

class LocationTab extends StatefulWidget {
  const LocationTab({
    super.key,
    required this.localizationSection,
    required this.locationId,
  });

  final LocalizationSection localizationSection;
  final int locationId;

  @override
  State<LocationTab> createState() => _LocationTabState();
}

class _LocationTabState extends State<LocationTab> {
  late final AuthBloc authBloc;

  @override
  void initState() {
    super.initState();
    authBloc = BlocProvider.of<AuthBloc>(context);
  }

  GoogleMapController? mapController;

  final LatLng initialPosition =
      const LatLng(-20.50246862307781, -54.61346732030084); // facom

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.p16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            gapH12,
            Text(
              widget.localizationSection.address,
              style: const TextStyle(
                fontSize: Sizes.p20,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (authBloc.state.status == AuthStateStatus.loggedIn) ...[
              gapH8,
              const Text(
                'Deixe sua avaliação',
                style: TextStyle(
                  fontSize: Sizes.p12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.grey,
                ),
              ),
              ReviewSection(
                locationId: widget.locationId,
              ),
            ] else
              gapH16,
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 200,
                width: MediaQuery.sizeOf(context).width * .8,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                clipBehavior: Clip.hardEdge,
                child: GoogleMap(
                  markers: {
                    Marker(
                      markerId: MarkerId(initialPosition.toString()),
                      position: initialPosition,
                    ),
                  },
                  cameraTargetBounds: CameraTargetBounds(
                    LatLngBounds(
                      southwest:
                          const LatLng(-20.511849614479797, -54.6221641078335),
                      northeast:
                          const LatLng(-20.493427224405206, -54.60504801228526),
                    ),
                  ),
                  initialCameraPosition: CameraPosition(
                    target: initialPosition,
                    zoom: 17,
                  ),
                  minMaxZoomPreference: const MinMaxZoomPreference(15, 20),
                  onMapCreated: _onMapCreated,
                  zoomControlsEnabled: false,
                  onTap: (argument) async {
                    // Abrir o Google Maps
                    final url = 'https://www.google.com/maps/search/?api=1&'
                        'query=${argument.latitude},${argument.longitude}&'
                        'query_place_id=ChIJmRhQAfXlhpQRKzU75yAgoaM';
                    final Uri uri = Uri.parse(url);
                    if (!await launchUrl(uri)) {
                      throw 'Could not launch $url';
                    }
                  },
                ),
              ),
            ),
            gapH4,
            const Center(
              child: Text(
                'Clique no mapa para abrir no Google Maps',
                style: TextStyle(
                  fontSize: Sizes.p14,
                  color: AppColors.secondary,
                ),
              ),
            ),
            gapH12,
          ],
        ),
      ),
    );
  }
}
