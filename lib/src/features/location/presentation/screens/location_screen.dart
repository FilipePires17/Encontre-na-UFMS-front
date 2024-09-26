import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common_widgets/custom_app_bar.dart';
import '../../../../core/constants/sizes/app_sizes.dart';
import '../../../../core/constants/theme/app_colors.dart';
import '../bloc/location_bloc.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key, required this.id});

  final int id;

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen>
    with TickerProviderStateMixin {
  late final TabController tabController;
  late final PageController pageController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    pageController = PageController();

    tabController.addListener(() {
      if (tabController.indexIsChanging) {
        debugPrint('Aba mudou para: ${tabController.index}');
        // Chame sua função personalizada aqui
      } else if (tabController.index != tabController.previousIndex) {
        debugPrint('Aba scrolou para: ${tabController.index}');
      }
    });

    tabController.animation!.addListener(() {
      debugPrint('Aba animou para: ${tabController.animation!.value}');
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    locationBloc.add(GetLocationEvent(widget.id));
    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppBar(
            text: state.location?.name ?? 'Facom',
            context: context,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.sizeOf(context).width,
                  width: double.infinity,
                  color: AppColors.primary,
                ),
                Container(
                  color: AppColors.charcoalGrey,
                  height: 80,
                  child: Row(
                    children: [
                      const Text(
                        'Facom',
                        style: TextStyle(fontSize: 20),
                      ),
                      gapW12,
                      const Text('3,5'),
                      const Icon(
                        Icons.star,
                        color: AppColors.yellow,
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(
                          Icons.star_border,
                          color: AppColors.secondary,
                          size: Sizes.p36,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                const Divider(
                  color: AppColors.black,
                  height: 1,
                ),
                Container(
                  color: AppColors.charcoalGrey,
                  height: 300,
                  child: Column(
                    children: [
                      TabBar(
                        controller: tabController,
                        tabs: const [
                          Tab(
                            text: 'Info',
                          ),
                          Tab(
                            text: 'Reviews',
                          ),
                        ],
                      ),
                      const Divider(
                        color: AppColors.black,
                        height: 1,
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: tabController,
                          children: const [
                            Text('Info'),
                            Text('Reviews'),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
