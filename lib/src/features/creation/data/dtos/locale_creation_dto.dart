import '../../../../core/utils/string_extension.dart';
import '../../../location/data/dtos/hours_section_dto.dart';
import '../../../location/data/dtos/special_info_dto.dart';
import '../../../location_listing/domain/enums/enum_location.dart';
import '../../../multimedia/data/dtos/multimedia_dto.dart';
import '../../domain/entities/locale_creation.dart';

class LocaleCreationDto extends LocaleCreation {
  const LocaleCreationDto({
    super.id,
    required super.name,
    required super.latitude,
    required super.longitude,
    required super.localizationLink,
    required super.address,
    super.multimedia = const <MultimediaDto>[],
    required super.hoursSection,
    super.phone,
    super.about,
    super.specialInfo,
    required super.type,
    super.hasAccessibility,
    super.observation,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'latitude': latitude.toString(),
      'longitude': longitude.toString(),
      'localizationLink': localizationLink,
      'address': address,
      'photos':
          multimedia.map((x) => MultimediaDto.fromEntity(x).toMap()).toList(),
      if (hoursSection != null)
        'schedule': HoursSectionDto.fromEntity(hoursSection!).toMap(),
      'phoneNumber': phone?.removeNonDigits(),
      'about': about,
      'specialInfo': specialInfo != null
          ? SpecialInfoDto.fromEntity(specialInfo!).toMap()
          : null,
      'type': EnumLocation.values.indexOf(type),
      'accessibility': hasAccessibility == true ? 1 : 0,
      'observation': observation,
    };
  }

  factory LocaleCreationDto.fromMap(Map<String, dynamic> map) {
    return LocaleCreationDto(
      id: map['id'],
      name: map['name'],
      latitude: map['latitude'] is double
          ? map['latitude']
          : double.parse(map['latitude']),
      longitude: map['longitude'] is double
          ? map['longitude']
          : double.parse(map['longitude']),
      localizationLink: map['localizationLink'],
      address: map['address'],
      multimedia: List<MultimediaDto>.from(
          map['photos']?.map((x) => MultimediaDto.fromMap(x)) ?? []),
      hoursSection: map['schedule'] != null
          ? HoursSectionDto.fromMap(map['schedule'])
          : null,
      phone: map['phoneNumber'],
      about: map['about'],
      specialInfo: map['specialInfo'] != null
          ? SpecialInfoDto.fromMap(map['specialInfo'])
          : null,
      type: EnumLocation.values[map['type']],
      hasAccessibility: map['accessibility'] == 1,
      observation: map['observation'],
    );
  }

  factory LocaleCreationDto.fromEntity(LocaleCreation entity) {
    return LocaleCreationDto(
      id: entity.id,
      name: entity.name,
      latitude: entity.latitude,
      longitude: entity.longitude,
      localizationLink: entity.localizationLink,
      address: entity.address,
      multimedia:
          entity.multimedia.map((x) => MultimediaDto.fromEntity(x)).toList(),
      hoursSection: entity.hoursSection != null
          ? HoursSectionDto.fromEntity(entity.hoursSection!)
          : null,
      phone: entity.phone,
      about: entity.about,
      specialInfo: entity.specialInfo != null
          ? SpecialInfoDto.fromEntity(entity.specialInfo!)
          : null,
      type: entity.type,
      hasAccessibility: entity.hasAccessibility,
      observation: entity.observation,
    );
  }
}
