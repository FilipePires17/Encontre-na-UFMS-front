import '../../domain/entities/location_list.dart';
import 'location_list_item_dto.dart';

class LocationListDto extends LocationList {
  const LocationListDto({
    required super.locationItems,
  });

  factory LocationListDto.fromMap(Map<String, dynamic> map) {
    return LocationListDto(
      locationItems: map['locales']
          .map<LocationListItemDto>((e) => LocationListItemDto.fromMap(e))
          .toList(),
    );
  }
}
