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
      sundayHours: map['sundayHours'] == null || map['sundayHours'].isEmpty
          ? 'Não informado'
          : map['sundayHours'],
      mondayHours: map['mondayHours'] == null || map['mondayHours'].isEmpty
          ? 'Não informado'
          : map['mondayHours'],
      tuesdayHours: map['tuesdayHours'] == null || map['tuesdayHours'].isEmpty
          ? 'Não informado'
          : map['tuesdayHours'],
      wednesdayHours:
          map['wednesdayHours'] == null || map['wednesdayHours'].isEmpty
              ? 'Não informado'
              : map['wednesdayHours'],
      thursdayHours:
          map['thursdayHours'] == null || map['thursdayHours'].isEmpty
              ? 'Não informado'
              : map['thursdayHours'],
      fridayHours: map['fridayHours'] == null || map['fridayHours'].isEmpty
          ? 'Não informado'
          : map['fridayHours'],
      saturdayHours:
          map['saturdayHours'] == null || map['saturdayHours'].isEmpty
              ? 'Não informado'
              : map['saturdayHours'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (sundayHours != null) 'sunday': sundayHours,
      if (mondayHours != null) 'monday': mondayHours,
      if (tuesdayHours != null) 'tuesday': tuesdayHours,
      if (wednesdayHours != null) 'wednesday': wednesdayHours,
      if (thursdayHours != null) 'thursday': thursdayHours,
      if (fridayHours != null) 'friday': fridayHours,
      if (saturdayHours != null) 'saturday': saturdayHours,
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
