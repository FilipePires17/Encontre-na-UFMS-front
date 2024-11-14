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
      sundayHours: map['sundayHours'] ?? 'Não informado',
      mondayHours: map['mondayHours'] ?? 'Não informado',
      tuesdayHours: map['tuesdayHours'] ?? 'Não informado',
      wednesdayHours: map['wednesdayHours'] ?? 'Não informado',
      thursdayHours: map['thursdayHours'] ?? 'Não informado',
      fridayHours: map['fridayHours'] ?? 'Não informado',
      saturdayHours: map['saturdayHours'] ?? 'Não informado',
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
