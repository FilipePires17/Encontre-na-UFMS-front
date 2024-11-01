import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/keys/route_names.dart';
import '../../../../core/constants/sizes/app_sizes.dart';
import '../../../../core/constants/theme/app_colors.dart';
import '../../domain/enums/enum_location.dart';
import '../bloc/location_listing_bloc.dart';
import '../cubit/location_categories_cubit.dart';
import '../widgets/category_tile.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/location_list_item_tile.dart';

class LocationListingScreen extends StatefulWidget {
  const LocationListingScreen({super.key});

  @override
  State<LocationListingScreen> createState() => _LocationListingScreenState();
}

class _LocationListingScreenState extends State<LocationListingScreen> {
  late LocationListingBloc locationListingBloc;
  late LocationCategoriesCubit locationCategoriesCubit;
  final scrollController = ScrollController();

  final searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    locationListingBloc = BlocProvider.of<LocationListingBloc>(context);
    locationCategoriesCubit = BlocProvider.of<LocationCategoriesCubit>(context);
    locationListingBloc.add(const LoadEvent());
    locationCategoriesCubit.clearCategories();

    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
              scrollController.offset &&
          scrollController.offset != 0) {
        locationListingBloc.add(
          LoadEvent(
            isFirstPage: false,
            locationsToFilter: locationCategoriesCubit.state,
          ),
        );
      }
    });

    searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(seconds: 1), () {
      if (searchController.text.isNotEmpty) {
        locationListingBloc.add(LoadEvent(
          query: searchController.text,
          locationsToFilter: locationCategoriesCubit.state,
        ));
      } else {
        locationListingBloc.add(LoadEvent(
          locationsToFilter: locationCategoriesCubit.state,
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    final notificationBarHeight = MediaQuery.of(context).padding.top;
    final bottomBarHeight = MediaQuery.of(context).padding.bottom;
    return Scaffold(
      drawer: CustomDrawer(
        onLogout: () {
          locationListingBloc.add(const LoadEvent());
          locationCategoriesCubit.clearCategories();
        },
      ),
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
                Expanded(
                  child: CustomTextField(
                    controller: searchController,
                    hintText: 'Procurar local',
                    height: Sizes.p40,
                    prefixIcon: const Icon(Icons.search),
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
                        LoadEvent(
                          locationsToFilter: state,
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
                  locationListingBloc.add(LoadEvent(
                    locationsToFilter: locationCategoriesCubit.state,
                  ));
                },
                child: CustomScrollView(
                  controller: scrollController,
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
                          Navigator.of(context).pushNamed(RouteNames.login);
                        }
                      },
                      builder: (context, state) {
                        switch (state.status) {
                          case LocationListingStatus.loaded:
                            return SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  return index <
                                          state.locations.locationItems.length
                                      ? Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(
                                                Sizes.p8,
                                              ),
                                              child: LocationListItemTile(
                                                location: state.locations
                                                    .locationItems[index],
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pushNamed(
                                                    RouteNames.location,
                                                    arguments: state
                                                        .locations
                                                        .locationItems[index]
                                                        .id,
                                                  );
                                                },
                                                onFavoritePressed: () {
                                                  locationListingBloc.add(
                                                    ToggleFavoriteEvent(
                                                      id: state
                                                          .locations
                                                          .locationItems[index]
                                                          .id,
                                                    ),
                                                  );
                                                },
                                                isFavorite: state
                                                        .locations
                                                        .locationItems[index]
                                                        .isFavorite ??
                                                    false,
                                              ),
                                            ),
                                            if (index !=
                                                state.locations.locationItems
                                                        .length -
                                                    1)
                                              Divider(
                                                indent:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.08,
                                                endIndent:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.08,
                                              ),
                                          ],
                                        )
                                      : const SizedBox(
                                          height: Sizes.p48,
                                          child: Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        );
                                },
                                childCount: state.hasReachedMax
                                    ? state.locations.locationItems.length
                                    : state.locations.locationItems.length + 1,
                              ),
                            );
                          default:
                            return const SliverFillRemaining(
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                        }
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
