import '../../domain/entities/sections.dart';

class LocalizationSectionDto extends LocalizationSection {
  const LocalizationSectionDto({
    required super.googleLink,
    required super.latitude,
    required super.longitude,
    required super.address,
  });

  factory LocalizationSectionDto.fromMap(Map<String, dynamic> map) {
    return LocalizationSectionDto(
      googleLink: map['localizationLink'],
      latitude: double.parse(map['latitude']),
      longitude: double.parse(map['longitude']),
      address: map['address'],
    );
  }

  LocalizationSection toEntity() {
    return LocalizationSection(
      googleLink: googleLink,
      latitude: latitude,
      longitude: longitude,
      address: address,
    );
  }
}
