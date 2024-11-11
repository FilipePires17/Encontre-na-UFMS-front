import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/location.dart';
import '../../../domain/usecases/get_location.dart';
import '../../../domain/usecases/toggle_favorite.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final GetLocation getLocation;
  final ToggleFavorite toggleFavorite;

  LocationBloc({
    required this.getLocation,
    required this.toggleFavorite,
  }) : super(const LocationState()) {
    on<GetLocationEvent>((event, emit) async {
      emit(state.copyWith(status: LocationStateStatus.loading));

      await getLocation(id: event.id).then(
        (result) => result.fold(
          (error) {
            emit(state.copyWith(
              status: LocationStateStatus.error,
              error: error,
            ));
          },
          (location) {
            emit(state.copyWith(
              status: LocationStateStatus.loaded,
              location: location,
            ));
          },
        ),
      );
    });

    on<ToggleFavoriteEvent>((event, emit) async {
      await toggleFavorite(id: event.id).then(
        (result) => result.fold(
          (error) {
            emit(state.copyWith(
              status: LocationStateStatus.error,
              error: error,
            ));
          },
          (location) {
            if (location) {
              emit(state.copyWith(
                status: LocationStateStatus.loaded,
                location: state.location!.copyWith(
                  isFavorite: !(state.location!.isFavorite ?? false),
                ),
              ));
              return;
            }

            emit(state.copyWith(status: LocationStateStatus.unauthorized));
            emit(state.copyWith(status: LocationStateStatus.loaded));
          },
        ),
      );
    });
  }
}
