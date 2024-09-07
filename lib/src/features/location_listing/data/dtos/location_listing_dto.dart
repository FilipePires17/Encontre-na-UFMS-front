import '../../../multimedia/data/dtos/multimedia_dto.dart';
import '../../domain/entities/location_list_item.dart';
import '../../domain/enums/enum_location.dart';

class LocationListItemDto extends LocationListItem {
  const LocationListItemDto({
    required super.id,
    required super.name,
    required super.address,
    MultimediaDto? multimedia,
    required super.type,
    super.isOpen,
    super.isFavorite,
  }) : super(multimedia: multimedia);

  factory LocationListItemDto.fromJson(Map<String, dynamic> json) {
    return LocationListItemDto(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      multimedia: json['multimedia'] != null
          ? MultimediaDto.fromJson(json['multimedia'])
          : null,
      type: EnumLocation.values
          .firstWhere((element) => element.toString() == json['type']),
      isOpen: json['isOpen'],
      isFavorite: json['isFavorite'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'multimedia': (multimedia as MultimediaDto?)?.toJson(),
      'type': type.toString(),
      'isOpen': isOpen,
      'isFavorite': isFavorite,
    };
  }
}
