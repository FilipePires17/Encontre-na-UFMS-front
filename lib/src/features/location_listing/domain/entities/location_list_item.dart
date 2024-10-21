import '../../../location/domain/entities/location.dart';
import '../../../multimedia/domain/entities/multimedia.dart';
import '../enums/enum_location.dart';

class LocationListItem extends Location {
  const LocationListItem({
    required super.id,
    required super.name,
    required this.address,
    super.multimedia = const [],
    super.isOpen,
    super.isFavorite,
    super.rating,
    super.hasAccessibility,
    required this.type,
  });

  final EnumLocation type;
  final String address;

  @override
  LocationListItem copyWith({
    int? id,
    String? name,
    String? address,
    List<Multimedia>? multimedia,
    bool? isOpen,
    bool? isFavorite,
    double? rating,
    bool? hasAccessibility,
    EnumLocation? type,
  }) {
    return LocationListItem(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      multimedia: multimedia ?? this.multimedia,
      isOpen: isOpen ?? this.isOpen,
      isFavorite: isFavorite ?? this.isFavorite,
      rating: rating ?? this.rating,
      hasAccessibility: hasAccessibility ?? this.hasAccessibility,
      type: type ?? this.type,
    );
  }
}
