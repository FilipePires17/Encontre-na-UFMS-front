import 'package:equatable/equatable.dart';

import 'location_list_item.dart';

class LocationList extends Equatable {
  const LocationList({
    this.locationItems = const [],
    this.totalItems = 0,
  });

  final List<LocationListItem> locationItems;
  final int totalItems;

  @override
  List<Object?> get props => [
        locationItems,
      ];
}

extension LocationListExtension on LocationList {
  bool get hasReachedMax => locationItems.length == totalItems;

  List<LocationListItem> getUpdatedList(List<LocationListItem> newItems) {
    final updatedList = List<LocationListItem>.from(locationItems);
    updatedList.addAll(newItems);
    return updatedList;
  }
}
