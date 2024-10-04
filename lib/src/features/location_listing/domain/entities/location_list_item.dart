import '../../../location/domain/entities/location.dart';
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
}
