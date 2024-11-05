import 'dart:convert';

import '../../../../config/environment/environment.dart';
import '../../domain/entities/multimedia.dart';

class MultimediaDto extends Multimedia {
  const MultimediaDto({
    super.id,
    super.name,
    super.mediaUrl,
    super.media,
  });

  factory MultimediaDto.fromMap(Map<String, dynamic> map) {
    return MultimediaDto(
      id: map['id'],
      name: map['name'],
      mediaUrl: baseUrlDev + map['url'].toString(),
      media: map['data'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'data': base64.encode(media!),
    };
  }

  factory MultimediaDto.fromEntity(Multimedia entity) {
    return MultimediaDto(
      id: entity.id,
      name: entity.name,
      mediaUrl: entity.mediaUrl,
      media: entity.media,
    );
  }
}
