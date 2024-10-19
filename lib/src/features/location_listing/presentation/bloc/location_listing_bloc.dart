import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/location_list_filter.dart';
import '../../domain/entities/location_list.dart';
import '../../domain/entities/location_list_item.dart';
import '../../domain/enums/enum_location.dart';
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
    on<LoadEvent>((event, emit) async {
      await loadEvent(
        isFirstPage: event.isFirstPage,
        filters: event.locationsToFilter,
        query: event.query,
        emit: emit,
      );
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
                List<LocationListItem>.from(state.locations.locationItems);
            final locationIndex = updatedLocations.indexWhere(
              (location) => location.id == event.id,
            );

            updatedLocations[locationIndex] = LocationListItem(
              id: updatedLocations[locationIndex].id,
              name: updatedLocations[locationIndex].name,
              address: updatedLocations[locationIndex].address,
              type: updatedLocations[locationIndex].type,
              isOpen: updatedLocations[locationIndex].isOpen,
              isFavorite:
                  !(updatedLocations[locationIndex].isFavorite ?? false),
              rating: updatedLocations[locationIndex].rating,
            );

            emit(state.copyWith(
              status: LocationListingStatus.loaded,
              locations: LocationList(
                locationItems: updatedLocations,
                totalItems: state.locations.totalItems,
              ),
            ));
          },
        );
      });
    });

    on<ResetLocationListingEvent>((event, emit) {
      emit(const LocationListingState());
    });
  }

  Future<void> loadEvent({
    bool isFirstPage = true,
    required List<EnumLocation> filters,
    String? query,
    required Emitter emit,
  }) async {
    if (isFirstPage) {
      emit(const LocationListingState(status: LocationListingStatus.loading));
    }

    if (state.hasReachedMax) return;

    emit(state.copyWith(
      pageIndex: isFirstPage ? 1 : state.pageIndex + 1,
    ));

    await getLocationListingPaginated(
      filter: LocationListFilter(
        pageIndex: state.pageIndex,
        query: query,
        types: filters,
      ),
    ).then((result) {
      result.fold(
        (error) {
          emit(state.copyWith(
            status: LocationListingStatus.error,
            errorMessage: 'Erro ao carregar locais',
          ));
        },
        (locations) {
          if (isFirstPage) {
            emit(state.copyWith(
              status: LocationListingStatus.loaded,
              locations: locations,
              hasReachedMax: locations.hasReachedMax,
            ));
          } else {
            final updatedLocations = LocationList(
              locationItems:
                  state.locations.getUpdatedList(locations.locationItems),
              totalItems: locations.totalItems,
            );

            emit(state.copyWith(
              locations: updatedLocations,
              hasReachedMax: updatedLocations.hasReachedMax,
            ));
          }
        },
      );
    });
  }
}
