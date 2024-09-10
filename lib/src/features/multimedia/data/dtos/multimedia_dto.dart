import '../../domain/entities/multimedia.dart';

class MultimediaDto extends Multimedia {
  const MultimediaDto({
    required super.id,
    super.name,
    required super.media,
  });

  factory MultimediaDto.fromMap(Map<String, dynamic> json) {
    return MultimediaDto(
      id: json['id'],
      name: json['name'],
      media: json['media'],
    );
  }
}
