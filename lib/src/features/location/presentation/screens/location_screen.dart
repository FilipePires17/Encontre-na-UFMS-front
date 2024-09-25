import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common_widgets/custom_app_bar.dart';
import '../bloc/location_bloc.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    locationBloc.add(GetLocationEvent(id));
    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppBar(
            text: state.location?.name ?? '',
            context: context,
          ),
        );
      },
    );
  }
}
