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

  factory LocationDto.fromMap(Map<String, dynamic> json) {
    return LocationDto(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      multimedia: json['multimedia']
          ?.map<MultimediaDto>((e) => MultimediaDto.fromMap(e))
          .toList(),
      type: EnumLocation.values
          .firstWhere((element) => element.toString() == json['type']),
      isOpen: json['isOpen'],
      isFavorite: json['isFavorite'],
    );
  }
}
