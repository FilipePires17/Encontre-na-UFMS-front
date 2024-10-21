import '../../../../core/constants/image.dart';
import '../../domain/entities/location_list.dart';
import 'location_list_item_dto.dart';

class LocationListDto extends LocationList {
  const LocationListDto({
    required super.locationItems,
    required super.totalItems,
  });

  factory LocationListDto.fromMap(Map<String, dynamic> map) {
    return LocationListDto(
      locationItems: map['locales']
          .map<LocationListItemDto>((e) => LocationListItemDto.fromMap(e
            // TODO: retirar quando a API começar a mandar a lista de imagens
            ..addAll({
              'multimedia': [
                {
                  'id': 1,
                  'name': 'name',
                  'media': imageMock,
                }
              ]
            })))
          .toList(),
      totalItems: map['totalItems'],
    );
  }
}
