part of 'location_listing_bloc.dart';

enum LocationListingStatus { initial, loading, loaded, error, unauthorized }

class LocationListingState extends Equatable {
  const LocationListingState({
    this.status = LocationListingStatus.initial,
    this.locations = const LocationList(),
    this.errorMessage,
  });

  final LocationListingStatus status;
  final LocationList locations;
  final String? errorMessage;

  LocationListingState copyWith({
    LocationListingStatus? status,
    LocationList? locations,
    String? errorMessage,
  }) {
    return LocationListingState(
      status: status ?? this.status,
      locations: locations ?? this.locations,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, locations, errorMessage];
}
