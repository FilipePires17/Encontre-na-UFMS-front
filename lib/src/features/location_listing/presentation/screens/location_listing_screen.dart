import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/sizes/app_sizes.dart';
import '../../domain/entities/location_list_filter.dart';
import '../../domain/enums/enum_location.dart';
import '../bloc/location_listing_bloc.dart';
import '../cubit/location_categories_cubit.dart';
import '../widgets/category_tile.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/location_list_item_tile.dart';

class LocationListingScreen extends StatefulWidget {
  const LocationListingScreen({super.key});

  @override
  State<LocationListingScreen> createState() => _LocationListingScreenState();
}

class _LocationListingScreenState extends State<LocationListingScreen> {
  late LocationListingBloc locationListingBloc;
  late LocationCategoriesCubit locationCategoriesCubit;

  @override
  void initState() {
    super.initState();
    locationListingBloc = BlocProvider.of<LocationListingBloc>(context);
    locationListingBloc.add(const LoadFilteredEvent());
    locationCategoriesCubit = BlocProvider.of<LocationCategoriesCubit>(context);
    locationCategoriesCubit.clearCategories();
  }

  @override
  void dispose() {
    locationListingBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notificationBarHeight = MediaQuery.of(context).padding.top;
    final bottomBarHeight = MediaQuery.of(context).padding.bottom;
    return Scaffold(
      drawer: const CustomDrawer(),
      body: Padding(
        padding: EdgeInsets.only(
          top: notificationBarHeight,
          bottom: bottomBarHeight,
        ),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Builder(builder: (context) {
                  return IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  );
                }),
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search location',
                    ),
                  ),
                ),
              ],
            ),
            gapH12,
            SizedBox(
              height: Sizes.p32,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: EnumLocation.values.length,
                separatorBuilder: (context, index) => gapW12,
                itemBuilder: (context, index) {
                  return BlocConsumer<LocationCategoriesCubit,
                      List<EnumLocation>>(
                    listener: (context, state) {
                      locationListingBloc.add(
                        LoadFilteredEvent(
                          paginatedFilters: LocationListFilter(
                            types: state,
                          ),
                        ),
                      );
                    },
                    builder: (context, state) {
                      return CategoryTile(
                        isPressed: state.contains(EnumLocation.values[index]),
                        location: EnumLocation.values[index],
                        onPressed: () async {
                          locationCategoriesCubit
                              .updateCategories(EnumLocation.values[index]);
                        },
                      );
                    },
                  );
                },
              ),
            ),
            gapH12,
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  locationListingBloc.add(LoadFilteredEvent(
                    paginatedFilters: LocationListFilter(
                      types: locationCategoriesCubit.state,
                    ),
                  ));
                },
                child: CustomScrollView(
                  slivers: [
                    BlocConsumer<LocationListingBloc, LocationListingState>(
                      listener: (context, state) {
                        if (state.status == LocationListingStatus.error) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.errorMessage ?? ''),
                            ),
                          );
                        } else if (state.status ==
                            LocationListingStatus.unauthorized) {
                          Navigator.of(context).pushNamed('/login');
                        }
                      },
                      builder: (context, state) {
                        return state.status == LocationListingStatus.loading
                            ? const SliverFillRemaining(
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(Sizes.p8),
                                      child: LocationListItemTile(
                                        location: state
                                            .locations.locationItems[index],
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pushNamed('/location');
                                        },
                                        onFavoritePressed: () {
                                          locationListingBloc.add(
                                            ToggleFavoriteEvent(
                                              id: state.locations
                                                  .locationItems[index].id,
                                            ),
                                          );
                                        },
                                        isFavorite: state
                                                .locations
                                                .locationItems[index]
                                                .isFavorite ??
                                            false,
                                      ),
                                    );
                                  },
                                  childCount:
                                      state.locations.locationItems.length,
                                ),
                              );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
