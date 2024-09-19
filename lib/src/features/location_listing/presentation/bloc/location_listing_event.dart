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
}

class LoadFilteredEvent extends LocationListingEvent {
  final LocationListFilter paginatedFilters;

  const LoadFilteredEvent({
    this.paginatedFilters = const LocationListFilter(),
  });
}

class ToggleFavoriteEvent extends LocationListingEvent {
  final int id;

  const ToggleFavoriteEvent({
    required this.id,
  });
}
