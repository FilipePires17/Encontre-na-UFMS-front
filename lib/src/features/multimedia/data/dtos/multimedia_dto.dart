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
      mediaUrl: map['url'] != null ? baseUrlDev + map['url'].toString() : null,
      media: map['data'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'name': name,
      if (id == null) 'data': base64.encode(media!),
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
