part of 'location_listing_bloc.dart';

sealed class LocationListingEvent extends Equatable {
  const LocationListingEvent();
}

class LoadEvent extends LocationListingEvent {
  final List<EnumLocation> locationsToFilter;
  final String? query;
  final bool isFirstPage;

  const LoadEvent({
    this.locationsToFilter = const [],
    this.query,
    this.isFirstPage = true,
  });

  @override
  List<Object?> get props => [locationsToFilter, query, isFirstPage];
}

class ToggleFavoriteEvent extends LocationListingEvent {
  final int id;

  const ToggleFavoriteEvent({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

class ResetLocationListingEvent extends LocationListingEvent {
  const ResetLocationListingEvent();

  @override
  List<Object?> get props => [];
}
