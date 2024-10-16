part of 'location_listing_bloc.dart';

sealed class LocationListingEvent extends Equatable {
  const LocationListingEvent();

  @override
  List<Object> get props => [];
}

class LoadEvent extends LocationListingEvent {
  final List<EnumLocation> locationsToFilter;
  final bool isFirstPage;

  const LoadEvent({
    this.locationsToFilter = const [],
    this.isFirstPage = true,
  });

  @override
  List<Object> get props => [locationsToFilter, isFirstPage];
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
}
