import 'package:flutter/material.dart';

import '../../../../core/constants/sizes/app_sizes.dart';
import '../../domain/enums/enum_location.dart';
import '../widgets/category_tile.dart';
import '../widgets/location_list_item_tile.dart';

class LocationListingScreen extends StatelessWidget {
  const LocationListingScreen({super.key});

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
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: LocationListItemTile(),
                        );
                      },
                      childCount: 15,
                    ),
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
