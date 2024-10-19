import '../../domain/entities/location_list_filter.dart';

class LocationListFilterDto extends LocationListFilter {
  const LocationListFilterDto({
    super.types = const [],
    super.pageIndex = 1,
    super.pageSize = 10,
    super.query,
  });

  Map<String, dynamic> toMap() {
    return {
      'pageNumber': pageIndex,
      'limit': pageSize,
      if (query != null) 'searchParam': query,
    };
  }

  factory LocationListFilterDto.fromDomain(LocationListFilter filter) {
    return LocationListFilterDto(
      types: filter.types,
      pageIndex: filter.pageIndex,
      pageSize: filter.pageSize,
      query: filter.query,
    );
  }
}
