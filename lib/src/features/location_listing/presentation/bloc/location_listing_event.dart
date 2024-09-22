part of 'location_listing_bloc.dart';

sealed class LocationListingEvent extends Equatable {
  const LocationListingEvent();

  @override
  List<Object> get props => [];
}

class LoadFullEvent extends LocationListingEvent {
  final LocationListFilter paginatedFilters;

  const LoadFullEvent({
    this.paginatedFilters = const LocationListFilter(),
  });

  @override
  List<Object> get props => [paginatedFilters];
}

class LoadFilteredEvent extends LocationListingEvent {
  final LocationListFilter paginatedFilters;

  const LoadFilteredEvent({
    this.paginatedFilters = const LocationListFilter(),
  });

  @override
  List<Object> get props => [paginatedFilters];
}

class ToggleFavoriteEvent extends LocationListingEvent {
  final int id;

  const ToggleFavoriteEvent({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}
