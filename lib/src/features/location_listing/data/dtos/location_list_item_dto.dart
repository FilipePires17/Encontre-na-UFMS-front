import '../../../multimedia/data/dtos/multimedia_dto.dart';
import '../../domain/entities/location_list_item.dart';
import '../../domain/enums/enum_location.dart';

class LocationListItemDto extends LocationListItem {
  const LocationListItemDto({
    required super.id,
    required super.name,
    required super.address,
    super.multimedia = const [],
    super.isOpen,
    super.isFavorite,
    super.rating,
    super.hasAccessibility,
    required super.type,
  });

  factory LocationListItemDto.fromMap(Map<String, dynamic> map) {
    return LocationListItemDto(
      id: map['id'],
      name: map['name'],
      address: map['address'],
      isOpen: map['isOpen'],
      isFavorite: map['favorite'] == 1,
      rating: double.parse(map['grade']),
      type: EnumLocation.values[map['type']],
      multimedia: map['multimedia']
              ?.map<MultimediaDto>((e) => MultimediaDto.fromMap(e))
              .toList() ??
          [],
    );
  }
}
