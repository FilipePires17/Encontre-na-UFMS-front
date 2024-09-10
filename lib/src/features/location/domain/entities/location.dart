import 'package:equatable/equatable.dart';

import '../../../location_listing/domain/enums/enum_location.dart';
import '../../../multimedia/domain/entities/multimedia.dart';

class Location extends Equatable {
  const Location({
    required this.id,
    required this.name,
    required this.address,
    this.multimedia = const [],
    required this.type,
    this.isOpen,
    this.isFavorite,
  });

  final int id;
  final String name;
  final String address;
  final List<Multimedia> multimedia;
  final EnumLocation type;
  final bool? isOpen;
  final bool? isFavorite;

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
