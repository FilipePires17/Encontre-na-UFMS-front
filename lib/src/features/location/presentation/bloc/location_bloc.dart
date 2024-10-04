import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/location.dart';
import '../../domain/usecases/get_location.dart';
import '../../domain/usecases/set_rating.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final GetLocation getLocation;
  final SetRating setRating;

  LocationBloc({
    required this.getLocation,
    required this.setRating,
  }) : super(const LocationState()) {
    on<GetLocationEvent>((event, emit) async {
      emit(const LocationState(status: LocationStateStatus.loading));
      // TODO: Implement GetLocationEvent
      await getLocation(id: event.id).then(
        (result) => result.fold(
          (error) {
            emit(LocationState(
              status: LocationStateStatus.error,
              error: error,
            ));
          },
          (location) {
            emit(LocationState(
              status: LocationStateStatus.loaded,
              location: location,
            ));
          },
        ),
      );
    });
  }
}
