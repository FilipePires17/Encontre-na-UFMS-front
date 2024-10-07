part of 'location_bloc.dart';

enum LocationStateStatus { initial, loading, loaded, error, unauthorized }

class LocationState extends Equatable {
  const LocationState({
    this.status = LocationStateStatus.initial,
    this.location,
    this.error,
  });

  final LocationStateStatus status;
  final Location? location;
  final String? error;

  LocationState copyWith({
    LocationStateStatus? status,
    Location? location,
    String? error,
  }) {
    return LocationState(
      status: status ?? this.status,
      location: location ?? this.location,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, location, error];
}
