import 'package:equatable/equatable.dart';

import '../../../multimedia/domain/entities/multimedia.dart';

class Location extends Equatable {
  const Location({
    required this.id,
    required this.name,
    this.multimedia = const [],
    this.isOpen,
    this.isFavorite,
    this.rating,
    this.hasAccessibility,
  });

  final int id;
  final String name;
  final List<Multimedia> multimedia;
  final bool? isOpen;
  final bool? isFavorite;
  final double? rating;
  final bool? hasAccessibility;

  Location copyWith({
    int? id,
    String? name,
    List<Multimedia>? multimedia,
    bool? isOpen,
    bool? isFavorite,
    double? rating,
    bool? hasAccessibility,
  }) {
    return Location(
      id: id ?? this.id,
      name: name ?? this.name,
      multimedia: multimedia ?? this.multimedia,
      isOpen: isOpen ?? this.isOpen,
      isFavorite: isFavorite ?? this.isFavorite,
      rating: rating ?? this.rating,
      hasAccessibility: hasAccessibility ?? this.hasAccessibility,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        multimedia,
        isOpen,
        isFavorite,
        rating,
      ];
}
