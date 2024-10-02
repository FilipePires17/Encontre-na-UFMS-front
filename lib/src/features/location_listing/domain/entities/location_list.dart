import 'package:equatable/equatable.dart';

import 'location_list_item.dart';

class LocationList extends Equatable {
  const LocationList({
    this.locationItems = const [],
  });

  final List<LocationListItem> locationItems;

  @override
  List<Object?> get props => [
        locationItems,
      ];
}
