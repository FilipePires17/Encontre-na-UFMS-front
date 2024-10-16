part of 'location_listing_bloc.dart';

enum LocationListingStatus { initial, loading, loaded, error, unauthorized }

class LocationListingState extends Equatable {
  const LocationListingState({
    this.status = LocationListingStatus.initial,
    this.locations = const LocationList(),
    this.hasReachedMax = false,
    this.errorMessage,
  });

  final LocationListingStatus status;
  final LocationList locations;
  final bool hasReachedMax;
  final String? errorMessage;

  LocationListingState copyWith({
    LocationListingStatus? status,
    LocationList? locations,
    bool? hasReachedMax,
    String? errorMessage,
  }) {
    return LocationListingState(
      status: status ?? this.status,
      locations: locations ?? this.locations,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, locations, hasReachedMax, errorMessage];
}
