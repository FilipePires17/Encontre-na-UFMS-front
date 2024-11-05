import '../../domain/entities/special_info.dart';

class SpecialInfoDto extends SpecialInfo {
  const SpecialInfoDto({
    super.course,
    super.libraryLink,
    super.availableSports,
    super.availableBuses,
    super.rules,
  });

  Map<String, dynamic> toMap() {
    return {
      'course': course,
      'libraryLink': libraryLink,
      'availableSports': availableSports,
      'availableBuses': availableBuses,
      'rules': rules,
    };
  }

  factory SpecialInfoDto.fromEntity(SpecialInfo entity) {
    return SpecialInfoDto(
      course: entity.course,
      libraryLink: entity.libraryLink,
      availableSports: entity.availableSports,
      availableBuses: entity.availableBuses,
      rules: entity.rules,
    );
  }
}
