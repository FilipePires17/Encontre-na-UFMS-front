import '../../domain/entities/multimedia.dart';

class MultimediaDto extends Multimedia {
  const MultimediaDto({
    required super.id,
    super.name,
    required super.media,
  });

  factory MultimediaDto.fromJson(Map<String, dynamic> json) {
    return MultimediaDto(
      id: json['id'],
      name: json['name'],
      media: json['media'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'media': media,
    };
  }
}
