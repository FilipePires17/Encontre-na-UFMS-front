import 'package:equatable/equatable.dart';

import '../../../location/domain/entities/location.dart';

class LocationListItem extends Equatable {
  const LocationListItem({
    this.locationItems = const [],
  });

  final List<Location> locationItems;

  @override
  List<Object?> get props => [
        locationItems,
      ];
}
