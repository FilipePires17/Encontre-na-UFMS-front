import 'package:equatable/equatable.dart';

import '../../../location_listing/domain/enums/enum_location.dart';
import 'special_info.dart';

class Section extends Equatable {
  const Section();

  @override
  List<Object?> get props => [];
}

class LocalizationSection extends Section {
  const LocalizationSection({
    required this.googleLink,
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  final String googleLink;
  final double latitude;
  final double longitude;
  final String address;

  LocalizationSection copyWith({
    String? googleLink,
    double? latitude,
    double? longitude,
    String? address,
  }) {
    return LocalizationSection(
      googleLink: googleLink ?? this.googleLink,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
    );
  }

  @override
  List<Object?> get props => [googleLink, latitude, longitude, address];
}

class HoursSection extends Section {
  final String? sundayHours;
  final String? mondayHours;
  final String? tuesdayHours;
  final String? wednesdayHours;
  final String? thursdayHours;
  final String? fridayHours;
  final String? saturdayHours;

  const HoursSection({
    this.sundayHours,
    this.mondayHours,
    this.tuesdayHours,
    this.wednesdayHours,
    this.thursdayHours,
    this.fridayHours,
    this.saturdayHours,
  }) : super();

  HoursSection copyWith({
    String? sundayHours,
    String? mondayHours,
    String? tuesdayHours,
    String? wednesdayHours,
    String? thursdayHours,
    String? fridayHours,
    String? saturdayHours,
  }) {
    return HoursSection(
      sundayHours: sundayHours ?? this.sundayHours,
      mondayHours: mondayHours ?? this.mondayHours,
      tuesdayHours: tuesdayHours ?? this.tuesdayHours,
      wednesdayHours: wednesdayHours ?? this.wednesdayHours,
      thursdayHours: thursdayHours ?? this.thursdayHours,
      fridayHours: fridayHours ?? this.fridayHours,
      saturdayHours: saturdayHours ?? this.saturdayHours,
    );
  }

  @override
  List<Object?> get props => [
        sundayHours,
        mondayHours,
        tuesdayHours,
        wednesdayHours,
        thursdayHours,
        fridayHours,
        saturdayHours,
      ];
}

class MoreInfoSection extends Section {
  final String? about;
  final String? observations;
  final String? phone;
  final EnumLocation? locationType;
  final SpecialInfo? specialInfo;

  const MoreInfoSection({
    this.about,
    this.observations,
    this.phone,
    this.locationType,
    this.specialInfo,
  }) : super();

  MoreInfoSection copyWith({
    String? about,
    String? phone,
    String? observations,
    EnumLocation? locationType,
    SpecialInfo? specialInfo,
  }) {
    return MoreInfoSection(
      about: about ?? this.about,
      phone: phone ?? this.phone,
      observations: observations ?? this.observations,
      locationType: locationType ?? this.locationType,
      specialInfo: specialInfo ?? this.specialInfo,
    );
  }

  @override
  List<Object?> get props => [
        about,
        phone,
        observations,
        locationType,
        specialInfo,
      ];
}

extension MoreInfoSectionExtension on MoreInfoSection {
  bool get hasInfo =>
      about != null ||
      observations != null ||
      phone != null ||
      specialInfo != null;
}
