import 'package:equatable/equatable.dart';

class Multimedia extends Equatable {
  const Multimedia({
    required this.id,
    this.name,
    required this.media,
  });

  final int id;
  final String? name;
  final String media;

  @override
  List<Object?> get props => [id, name, media];
}
