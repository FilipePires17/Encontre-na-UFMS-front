import 'package:equatable/equatable.dart';

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
  final String sundayHours;
  final String mondayHours;
  final String tuesdayHours;
  final String wednesdayHours;
  final String thursdayHours;
  final String fridayHours;
  final String saturdayHours;

  const HoursSection({
    required this.sundayHours,
    required this.mondayHours,
    required this.tuesdayHours,
    required this.wednesdayHours,
    required this.thursdayHours,
    required this.fridayHours,
    required this.saturdayHours,
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
  final String about;
  final String phone;
  final String observations;

  const MoreInfoSection({
    required this.about,
    required this.phone,
    required this.observations,
  }) : super();

  MoreInfoSection copyWith({
    String? about,
    String? phone,
    String? observations,
  }) {
    return MoreInfoSection(
      about: about ?? this.about,
      phone: phone ?? this.phone,
      observations: observations ?? this.observations,
    );
  }

  @override
  List<Object?> get props => [about, phone, observations];
}
