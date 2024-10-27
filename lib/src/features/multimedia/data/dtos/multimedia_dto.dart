import 'dart:convert';

import '../../domain/entities/multimedia.dart';

class MultimediaDto extends Multimedia {
  const MultimediaDto({
    required super.id,
    super.name,
    required super.media,
  });

  factory MultimediaDto.fromMap(Map<String, dynamic> map) {
    return MultimediaDto(
      id: map['id'],
      name: map['name'],
      media: base64Decode((map['data'] as String).split(':').last),
    );
  }
}
