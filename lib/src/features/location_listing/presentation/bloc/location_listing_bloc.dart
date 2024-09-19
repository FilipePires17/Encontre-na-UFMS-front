import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/location_list_filter.dart';
import '../../domain/entities/location_list_item.dart';
import '../../domain/usecases/get_location_listing_paginated.dart';
import '../../domain/usecases/toggle_favorite_location.dart';

part 'location_listing_event.dart';
part 'location_listing_state.dart';

class LocationListingBloc
    extends Bloc<LocationListingEvent, LocationListingState> {
  final GetLocationListingPaginated getLocationListingPaginated;
  final ToggleFavoriteLocation toggleFavoriteLocation;

  LocationListingBloc({
    required this.getLocationListingPaginated,
    required this.toggleFavoriteLocation,
  }) : super(const LocationListingState()) {
    on<LoadFilteredEvent>((event, emit) async {
      emit(state.copyWith(status: LocationListingStatus.loading));

      await getLocationListingPaginated(
        filter: event.paginatedFilters,
      ).then((result) {
        result.fold(
          (error) {
            emit(state.copyWith(
              status: LocationListingStatus.error,
              errorMessage: 'Error loading locations',
            ));
          },
          (locations) {
            emit(state.copyWith(
              status: LocationListingStatus.loaded,
              locations: locations,
            ));
          },
        );
      });
    });
  }
}
