import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class Multimedia extends Equatable {
  const Multimedia({
    this.id,
    this.name,
    this.mediaUrl,
    this.media,
  });

  final int? id;
  final String? name;
  final String? mediaUrl;
  final Uint8List? media;

  @override
  List<Object?> get props => [id, name, mediaUrl, media];
}
