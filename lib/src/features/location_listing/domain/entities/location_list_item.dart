import 'package:equatable/equatable.dart';

import '../enums/enum_location.dart';
import '../../../multimedia/domain/entities/multimedia.dart';

class LocationListItem extends Equatable {
  const LocationListItem({
    required this.id,
    required this.name,
    required this.address,
    this.multimedia,
    required this.type,
    this.isOpen,
    this.isFavorite,
  });

  final int id;
  final String name;
  final String address;
  final Multimedia? multimedia;
  final EnumLocation type;
  final bool? isOpen;
  final bool? isFavorite;

  @override
  List<Object?> get props =>
      [id, name, address, multimedia, type, isOpen, isFavorite];
}
