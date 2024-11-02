import 'package:equatable/equatable.dart';

import '../../../location/domain/entities/sections.dart';
import '../../../multimedia/domain/entities/multimedia.dart';

class LocaleCreation extends Equatable {
  const LocaleCreation({
    required this.localizationLink,
    required this.latitude,
    required this.longitude,
    this.multimedia = const [],
    required this.hoursSection,
    this.phone,
    this.about,
    this.specialInfo,
  });

  final double latitude;
  final double longitude;
  final String localizationLink;
  final List<Multimedia> multimedia;
  final HoursSection hoursSection;
  final String? phone;
  final String? about;
  final String? specialInfo;

  LocaleCreation copyWith({
    double? latitude,
    double? longitude,
    String? localizationLink,
    List<Multimedia>? multimedia,
    HoursSection? hoursSection,
    String? phone,
    String? about,
    String? specialInfo,
  }) {
    return LocaleCreation(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      localizationLink: localizationLink ?? this.localizationLink,
      multimedia: multimedia ?? this.multimedia,
      hoursSection: hoursSection ?? this.hoursSection,
      phone: phone ?? this.phone,
      about: about ?? this.about,
      specialInfo: specialInfo ?? this.specialInfo,
    );
  }

  @override
  List<Object?> get props => [
        latitude,
        longitude,
        localizationLink,
        multimedia,
        hoursSection,
        phone,
        about,
        specialInfo,
      ];
}
