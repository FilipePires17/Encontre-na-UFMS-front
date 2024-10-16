import 'package:equatable/equatable.dart';

import '../enums/enum_location.dart';

class LocationListFilter extends Equatable {
  const LocationListFilter({
    this.types = const [],
    this.pageIndex = 1,
    this.pageSize = 10,
  });

  final List<EnumLocation> types;
  final int pageIndex;
  final int pageSize;

  LocationListFilter copyWith({
    List<EnumLocation>? types,
    int? pageIndex,
    int? pageSize,
  }) {
    return LocationListFilter(
      types: types ?? this.types,
      pageIndex: pageIndex ?? this.pageIndex,
      pageSize: pageSize ?? this.pageSize,
    );
  }

  @override
  List<Object?> get props => [
        types,
        pageIndex,
        pageSize,
      ];
}
