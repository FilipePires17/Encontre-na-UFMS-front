import 'package:equatable/equatable.dart';

class SpecialInfo extends Equatable {
  const SpecialInfo({
    this.course,
    this.libraryLink,
    this.availableSports,
    this.availableBuses,
    this.rules,
  });

  final String? course;
  final String? libraryLink;
  final String? availableSports;
  final String? availableBuses;
  final String? rules;

  SpecialInfo copyWith({
    String? course,
    String? libraryLink,
    String? availableSports,
    String? availableBuses,
    String? rules,
  }) {
    return SpecialInfo(
      course: course ?? this.course,
      libraryLink: libraryLink ?? this.libraryLink,
      availableSports: availableSports ?? this.availableSports,
      availableBuses: availableBuses ?? this.availableBuses,
      rules: rules ?? this.rules,
    );
  }

  @override
  List<Object?> get props => [
        course,
        libraryLink,
        availableSports,
        availableBuses,
        rules,
      ];
}
