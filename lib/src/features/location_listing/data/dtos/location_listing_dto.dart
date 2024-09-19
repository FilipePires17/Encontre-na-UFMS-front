import '../../../location/data/dtos/location_dto.dart';
import '../../domain/entities/location_list_item.dart';

class LocationListItemDto extends LocationList {
  const LocationListItemDto({
    required super.locationItems,
  });

  factory LocationListItemDto.fromMap(Map<String, dynamic> map) {
    return LocationListItemDto(
      locationItems: map['locales']
          .map<LocationDto>((e) => LocationDto.fromMap(e))
          .toList(),
    );
  }
}
