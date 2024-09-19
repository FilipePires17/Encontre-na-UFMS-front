import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/sizes/app_sizes.dart';
import '../../domain/enums/enum_location.dart';
import '../bloc/location_listing_bloc.dart';
import '../widgets/category_tile.dart';
import '../widgets/location_list_item_tile.dart';

class LocationListingScreen extends StatefulWidget {
  const LocationListingScreen({super.key});

  @override
  State<LocationListingScreen> createState() => _LocationListingScreenState();
}

class _LocationListingScreenState extends State<LocationListingScreen> {
  late LocationListingBloc locationListingBloc;

  @override
  void initState() {
    super.initState();
    locationListingBloc = BlocProvider.of<LocationListingBloc>(context);
    locationListingBloc.add(const LoadFilteredEvent());
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
      drawer: const Drawer(),
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
                  return CategoryTile(
                    location: EnumLocation.values[index],
                    onPressed: () {},
                  );
                },
              ),
            ),
            gapH12,
            Expanded(
              child: CustomScrollView(
                slivers: [
                  BlocBuilder<LocationListingBloc, LocationListingState>(
                    builder: (context, state) {
                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(Sizes.p8),
                              child: LocationListItemTile(
                                location: state.locations.locationItems[index],
                              ),
                            );
                          },
                          childCount: state.locations.locationItems.length,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
