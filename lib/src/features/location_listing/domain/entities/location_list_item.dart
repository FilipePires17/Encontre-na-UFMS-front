import 'package:equatable/equatable.dart';

import '../../../location/domain/entities/location.dart';

class LocationList extends Equatable {
  const LocationList({
    this.locationItems = const [],
  });

  final List<Location> locationItems;

  @override
  List<Object?> get props => [
        locationItems,
      ];
}
