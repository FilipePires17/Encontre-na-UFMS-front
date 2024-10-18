import '../../../location_listing/data/dtos/location_list_dto.dart';
import '../../domain/entities/search.dart';

class SearchDto extends Search {
  const SearchDto({
    super.query,
    super.results,
  });

  factory SearchDto.fromMap(Map<String, dynamic> map, String query) {
    return SearchDto(
      query: query,
      results: LocationListDto.fromMap(map['results']),
    );
  }

  Map<String, dynamic> toMap() {
    return {'query': query};
  }
}
