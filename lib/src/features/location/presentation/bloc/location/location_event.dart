part of 'location_bloc.dart';

sealed class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class GetLocationEvent extends LocationEvent {
  final int id;

  const GetLocationEvent(this.id);

  @override
  List<Object> get props => [id];
}

class SetRatingEvent extends LocationEvent {
  final int id;
  final double rating;

  const SetRatingEvent(this.id, this.rating);

  @override
  List<Object> get props => [id, rating];
}
