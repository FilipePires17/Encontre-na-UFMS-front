import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class Multimedia extends Equatable {
  const Multimedia({
    this.id,
    this.name,
    required this.media,
  });

  final int? id;
  final String? name;
  final Uint8List media;

  @override
  List<Object?> get props => [id, name, media];
}
