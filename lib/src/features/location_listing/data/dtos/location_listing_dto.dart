import '../../../location/data/dtos/location_dto.dart';
import '../../domain/entities/location_list_item.dart';

class LocationListItemDto extends LocationListItem {
  const LocationListItemDto({
    required super.locationItems,
  });

  factory LocationListItemDto.fromJson(Map<String, dynamic> json) {
    return LocationListItemDto(
      locationItems: json['locationItems']
          ?.map<LocationDto>((e) => LocationDto.fromMap(e))
          .toList(),
    );
  }
}
