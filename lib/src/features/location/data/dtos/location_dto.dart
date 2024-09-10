import '../../../location_listing/domain/enums/enum_location.dart';
import '../../../multimedia/data/dtos/multimedia_dto.dart';
import '../../domain/entities/location.dart';

class LocationDto extends Location {
  const LocationDto({
    required super.id,
    required super.name,
    required super.address,
    List<MultimediaDto> multimedia = const [],
    required super.type,
    super.isOpen,
    super.isFavorite,
  }) : super(
          multimedia: multimedia,
        );

  factory LocationDto.fromJson(Map<String, dynamic> json) {
    return LocationDto(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      multimedia: json['multimedia']
          ?.map<MultimediaDto>((e) => MultimediaDto.fromJson(e))
          .toList(),
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
      'type': type.jsonName,
      'isOpen': isOpen,
      'isFavorite': isFavorite,
    };
  }
}
