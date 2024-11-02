import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/creation_cubit.dart';

class LocationCreationScreen extends StatefulWidget {
  const LocationCreationScreen({super.key});

  @override
  State<LocationCreationScreen> createState() => _LocationCreationScreenState();
}

class _LocationCreationScreenState extends State<LocationCreationScreen> {
  late final CreationCubit creationCubit;

  @override
  void initState() {
    creationCubit = BlocProvider.of<CreationCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
