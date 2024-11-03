import '../../domain/entities/sections.dart';

class HoursSectionDto extends HoursSection {
  const HoursSectionDto({
    super.sundayHours,
    super.mondayHours,
    super.tuesdayHours,
    super.wednesdayHours,
    super.thursdayHours,
    super.fridayHours,
    super.saturdayHours,
  });

  factory HoursSectionDto.fromMap(Map<String, dynamic> map) {
    return HoursSectionDto(
      sundayHours: map['sundayHours'],
      mondayHours: map['mondayHours'],
      tuesdayHours: map['tuesdayHours'],
      wednesdayHours: map['wednesdayHours'],
      thursdayHours: map['thursdayHours'],
      fridayHours: map['fridayHours'],
      saturdayHours: map['saturdayHours'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'sunday': sundayHours,
      'monday': mondayHours,
      'tuesday': tuesdayHours,
      'wednesday': wednesdayHours,
      'thursday': thursdayHours,
      'friday': fridayHours,
      'saturday': saturdayHours,
    };
  }

  factory HoursSectionDto.fromEntity(HoursSection entity) {
    return HoursSectionDto(
      sundayHours: entity.sundayHours,
      mondayHours: entity.mondayHours,
      tuesdayHours: entity.tuesdayHours,
      wednesdayHours: entity.wednesdayHours,
      thursdayHours: entity.thursdayHours,
      fridayHours: entity.fridayHours,
      saturdayHours: entity.saturdayHours,
    );
  }
}
