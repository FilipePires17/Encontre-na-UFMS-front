import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../location/domain/entities/location.dart';
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
      emit(state.copyWith(
        status: LocationListingStatus.loading,
        locations: null,
      ));

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

    on<ToggleFavoriteEvent>((event, emit) async {
      await toggleFavoriteLocation(
        id: event.id,
      ).then((result) {
        result.fold(
          (error) {
            emit(state.copyWith(
              status: LocationListingStatus.error,
              errorMessage: 'Error toggling favorite',
            ));
          },
          (isFavorited) {
            if (!isFavorited) {
              emit(state.copyWith(
                status: LocationListingStatus.unauthorized,
              ));
              return;
            }

            final updatedLocations =
                List<Location>.from(state.locations.locationItems);
            final locationIndex = updatedLocations.indexWhere(
              (location) => location.id == event.id,
            );

            updatedLocations[locationIndex] = Location(
              id: updatedLocations[locationIndex].id,
              name: updatedLocations[locationIndex].name,
              address: updatedLocations[locationIndex].address,
              type: updatedLocations[locationIndex].type,
              isOpen: updatedLocations[locationIndex].isOpen,
              isFavorite: isFavorited,
              rating: updatedLocations[locationIndex].rating,
            );

            emit(state.copyWith(
              status: LocationListingStatus.loaded,
              locations: LocationList(locationItems: updatedLocations),
            ));
          },
        );
      });
    });
  }
}
