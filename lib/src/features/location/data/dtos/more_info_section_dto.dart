import '../../../location_listing/domain/enums/enum_location.dart';
import '../../domain/entities/sections.dart';
import 'special_info_dto.dart';

class MoreInfoSectionDto extends MoreInfoSection {
  const MoreInfoSectionDto({
    super.about,
    super.observations,
    super.phone,
    super.locationType,
    super.specialInfo,
  });

  factory MoreInfoSectionDto.fromMap(Map<String, dynamic> map) {
    return MoreInfoSectionDto(
      about: map['about'],
      observations: map['observation'],
      phone: map['phoneNumber'],
      locationType: EnumLocation.values[map['type']],
      specialInfo: SpecialInfoDto.fromMap(map),
    );
  }
}
