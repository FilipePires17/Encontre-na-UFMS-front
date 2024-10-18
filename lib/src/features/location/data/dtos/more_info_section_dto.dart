import '../../domain/entities/sections.dart';

class MoreInfoSectionDto extends MoreInfoSection {
  const MoreInfoSectionDto({
    super.about,
    super.observations,
    required super.phone,
  });

  factory MoreInfoSectionDto.fromMap(Map<String, dynamic> map) {
    return MoreInfoSectionDto(
      about: map['about'],
      observations: map['observations'],
      phone: map['phoneNumber'],
    );
  }
}
