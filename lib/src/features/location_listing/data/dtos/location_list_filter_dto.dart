import '../../domain/entities/location_list_filter.dart';

class LocationListFilterDto extends LocationListFilter {
  const LocationListFilterDto({
    super.types = const [],
    super.pageIndex = 1,
    super.pageSize = 10,
  });

  Map<String, dynamic> toMap() {
    return {
      'types': types.map((e) => e.jsonName).toList().join(','),
      'pageIndex': pageIndex,
      'pageSize': pageSize,
    };
  }
}
