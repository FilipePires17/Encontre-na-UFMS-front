import '../../../multimedia/data/dtos/multimedia_dto.dart';
import '../../domain/entities/location.dart';

class LocationDto extends Location {
  const LocationDto({
    required super.id,
    required super.name,
    List<MultimediaDto> multimedia = const [],
    super.isOpen,
    super.isFavorite,
    super.rating,
  }) : super(
          multimedia: multimedia,
        );

  factory LocationDto.fromMap(Map<String, dynamic> map) {
    return LocationDto(
      id: map['id'],
      name: map['name'],
      // multimedia: map['multimedia']
      //     ?.map<MultimediaDto>((e) => MultimediaDto.fromMap(e))
      //     .toList(),
      isOpen: map['isOpen'],
      isFavorite: map['favorite'] == 1,
      rating: double.parse(map['grade']),
    );
  }
}
