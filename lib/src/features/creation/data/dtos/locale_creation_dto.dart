import '../../../location/data/dtos/hours_section_dto.dart';
import '../../../multimedia/data/dtos/multimedia_dto.dart';
import '../../domain/entities/locale_creation.dart';

class LocaleCreationDto extends LocaleCreation {
  const LocaleCreationDto({
    required super.localizationLink,
    required super.latitude,
    required super.longitude,
    super.multimedia = const <MultimediaDto>[],
    required super.hoursSection,
    super.phone,
    super.about,
    super.specialInfo,
  });

  Map<String, dynamic> toMap() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'localizationLink': localizationLink,
      'multimedia':
          multimedia.map((x) => MultimediaDto.fromEntity(x).toMap()).toList(),
      'hoursSection': HoursSectionDto.fromEntity(hoursSection).toMap(),
      'phone': phone,
      'about': about,
      'specialInfo': specialInfo,
    };
  }
}
