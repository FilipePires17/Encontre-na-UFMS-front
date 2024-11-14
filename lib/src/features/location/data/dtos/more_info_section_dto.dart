import '../../domain/entities/sections.dart';

class MoreInfoSectionDto extends MoreInfoSection {
  const MoreInfoSectionDto({
    super.about,
    super.observations,
    super.phone,
  });

  factory MoreInfoSectionDto.fromMap(Map<String, dynamic> map) {
    return MoreInfoSectionDto(
      about: map['about'],
      observations: map['observation'],
      phone: map['phoneNumber'],
    );
  }
}
