import 'package:equatable/equatable.dart';

import '../../../location/domain/entities/sections.dart';
import '../../../location/domain/entities/special_info.dart';
import '../../../location_listing/domain/enums/enum_location.dart';
import '../../../multimedia/domain/entities/multimedia.dart';

class LocaleCreation extends Equatable {
  const LocaleCreation({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.localizationLink,
    required this.address,
    this.multimedia = const [],
    this.hoursSection,
    this.phone,
    this.about,
    this.specialInfo,
    required this.type,
    this.hasAccessibility,
    this.observation,
  });

  final String name;
  final double latitude;
  final double longitude;
  final String localizationLink;
  final String address;
  final List<Multimedia> multimedia;
  final HoursSection? hoursSection;
  final String? phone;
  final String? about;
  final SpecialInfo? specialInfo;
  final EnumLocation type;
  final bool? hasAccessibility;
  final String? observation;

  LocaleCreation copyWith({
    String? name,
    double? latitude,
    double? longitude,
    String? localizationLink,
    String? address,
    List<Multimedia>? multimedia,
    HoursSection? hoursSection,
    String? phone,
    String? about,
    SpecialInfo? specialInfo,
    EnumLocation? type,
    bool? hasAccessibility,
    String? observation,
  }) {
    return LocaleCreation(
      name: name ?? this.name,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      localizationLink: localizationLink ?? this.localizationLink,
      address: address ?? this.address,
      multimedia: multimedia ?? this.multimedia,
      hoursSection: hoursSection ?? this.hoursSection,
      phone: phone ?? this.phone,
      about: about ?? this.about,
      specialInfo: specialInfo ?? this.specialInfo,
      type: type ?? this.type,
      hasAccessibility: hasAccessibility ?? this.hasAccessibility,
      observation: observation ?? this.observation,
    );
  }

  @override
  List<Object?> get props => [
        name,
        latitude,
        longitude,
        localizationLink,
        address,
        multimedia,
        hoursSection,
        phone,
        about,
        specialInfo,
        type,
        hasAccessibility,
        observation,
      ];
}
