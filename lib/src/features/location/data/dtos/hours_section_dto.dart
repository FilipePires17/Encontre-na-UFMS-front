import '../../domain/entities/sections.dart';

class HoursSectionDto extends HoursSection {
  const HoursSectionDto({
    required super.sundayHours,
    required super.mondayHours,
    required super.tuesdayHours,
    required super.wednesdayHours,
    required super.thursdayHours,
    required super.fridayHours,
    required super.saturdayHours,
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

  HoursSection toEntity() {
    return HoursSection(
      sundayHours: sundayHours,
      mondayHours: mondayHours,
      tuesdayHours: tuesdayHours,
      wednesdayHours: wednesdayHours,
      thursdayHours: thursdayHours,
      fridayHours: fridayHours,
      saturdayHours: saturdayHours,
    );
  }
}
