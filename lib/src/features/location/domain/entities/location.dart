import 'package:equatable/equatable.dart';

import '../../../multimedia/domain/entities/multimedia.dart';

class Location extends Equatable {
  const Location({
    required this.id,
    required this.name,
    required this.address,
    this.multimedia = const [],
    this.isOpen,
    this.isFavorite,
    this.rating,
    this.hasAccessibility,
  });

  final int id;
  final String name;
  final String address;
  final List<Multimedia> multimedia;
  final bool? isOpen;
  final bool? isFavorite;
  final double? rating;
  final bool? hasAccessibility;

  @override
  List<Object?> get props => [
        id,
        name,
        address,
        multimedia,
        isOpen,
        isFavorite,
        rating,
      ];
}
