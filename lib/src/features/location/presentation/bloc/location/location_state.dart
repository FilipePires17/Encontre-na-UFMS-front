part of 'location_bloc.dart';

enum LocationStateStatus { initial, loading, loaded, error }

class LocationState extends Equatable {
  const LocationState({
    this.status = LocationStateStatus.initial,
    this.location,
    this.error,
  });

  final LocationStateStatus status;
  final Location? location;
  final String? error;

  @override
  List<Object?> get props => [status, location, error];
}
