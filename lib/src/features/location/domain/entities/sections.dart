import 'package:equatable/equatable.dart';

sealed class Section extends Equatable {
  const Section();
}

class LocalizationSection extends Section {
  final String googleLink;
  final double latitude;
  final double longitude;

  const LocalizationSection({
    required this.googleLink,
    required this.latitude,
    required this.longitude,
  }) : super();

  @override
  List<Object?> get props => [googleLink, latitude, longitude];
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

  @override
  List<Object?> get props => [about, phone, observations];
}
