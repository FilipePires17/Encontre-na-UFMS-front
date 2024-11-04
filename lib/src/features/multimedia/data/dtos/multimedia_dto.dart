import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../domain/entities/multimedia.dart';

class MultimediaDto extends Multimedia {
  const MultimediaDto({
    super.id,
    super.name,
    required super.media,
  });

  factory MultimediaDto.fromMap(Map<String, dynamic> map) {
    Uint8List media;

    try {
      media = base64.decode(
        (map['data'] as String).split(':').last.replaceAll(r'\n|\r', ''),
      );
    } catch (e) {
      debugPrint('Error decoding multimedia: $e');
      media = Uint8List(0);
    }

    return MultimediaDto(
      id: map['id'],
      name: map['name'] ?? '',
      media: media,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': super.name,
      'media': base64.encode(super.media),
    };
  }

  factory MultimediaDto.fromEntity(Multimedia entity) {
    return MultimediaDto(
      id: entity.id,
      name: entity.name,
      media: entity.media,
    );
  }
}
