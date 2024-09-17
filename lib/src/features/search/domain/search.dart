import 'package:equatable/equatable.dart';

import '../../location_listing/domain/entities/location_list_item.dart';

class Search extends Equatable {
  const Search({
    this.query,
    this.results = const [],
  });

  final String? query;
  final List<LocationListItem> results;

  @override
  List<Object?> get props => [query, results];
}
