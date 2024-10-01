import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/sizes/app_sizes.dart';

class LocationTab extends StatefulWidget {
  const LocationTab({super.key});

  @override
  State<LocationTab> createState() => _LocationTabState();
}

class _LocationTabState extends State<LocationTab> {
  GoogleMapController? mapController;

  final LatLng initialPosition =
      const LatLng(-20.50246862307781, -54.61346732030084); // São Paulo, Brasil

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.p16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          gapH4,
          const Text(
            'Rua da Facom, 645 - Cidade Universitária, Campo Grande - MS',
          ),
          gapH4,
          const Text(
            '(67) 3345-3500',
          ),
          gapH4,
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
        ],
      ),
    );
  }
}
