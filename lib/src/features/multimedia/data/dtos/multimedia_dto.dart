import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../domain/entities/multimedia.dart';

class MultimediaDto extends Multimedia {
  const MultimediaDto({
    required super.id,
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
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      media: media,
    );
  }
}
