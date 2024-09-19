import '../../domain/entities/location_list_filter.dart';
import '../../domain/enums/enum_location.dart';

class LocationListFilterDto extends LocationListFilter {
  const LocationListFilterDto({
    super.types = const [EnumLocation.academicBlocks],
    super.pageIndex = 1,
    super.pageSize = 10,
  });

  Map<String, dynamic> toMap() {
    return {
      'pageNumber': pageIndex,
      'limit': pageSize,
      'userId': 0,
    };
  }

  factory LocationListFilterDto.fromDomain(LocationListFilter filter) {
    return LocationListFilterDto(
      types: filter.types,
      pageIndex: filter.pageIndex,
      pageSize: filter.pageSize,
    );
  }
}
