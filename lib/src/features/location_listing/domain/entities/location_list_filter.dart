import 'package:equatable/equatable.dart';

import '../enums/enum_location.dart';

class LocationListFilter extends Equatable {
  const LocationListFilter({
    this.types = const [],
    this.pageIndex = 1,
    this.pageSize = 10,
    this.query,
  });

  final List<EnumLocation> types;
  final int pageIndex;
  final int pageSize;
  final String? query;

  LocationListFilter copyWith({
    List<EnumLocation>? types,
    int? pageIndex,
    int? pageSize,
    String? query,
  }) {
    return LocationListFilter(
      types: types ?? this.types,
      pageIndex: pageIndex ?? this.pageIndex,
      pageSize: pageSize ?? this.pageSize,
      query: query ?? this.query,
    );
  }

  @override
  List<Object?> get props => [
        types,
        pageIndex,
        pageSize,
        query,
      ];
}
