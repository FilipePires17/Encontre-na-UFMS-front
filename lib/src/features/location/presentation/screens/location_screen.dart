import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common_widgets/custom_app_bar.dart';
import '../../../../core/constants/sizes/app_sizes.dart';
import '../../../../core/constants/theme/app_colors.dart';
import '../bloc/location_bloc.dart';
import '../widgets/information_tab.dart';
import '../widgets/location_tab.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key, required this.id});

  final int id;

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen>
    with TickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    locationBloc.add(GetLocationEvent(widget.id));
    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, state) {
        return state.location == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Scaffold(
                appBar: CustomAppBar(
                  text: state.location!.name,
                  context: context,
                ),
                body: Column(
                  children: [
                    Container(
                      height: 200, //MediaQuery.sizeOf(context).width,
                      width: double.infinity,
                      color: AppColors.primary,
                    ),
                    Container(
                      color: AppColors.charcoalGrey,
                      height: 80,
                      padding:
                          const EdgeInsets.symmetric(horizontal: Sizes.p16),
                      child: Row(
                        children: [
                          Text(
                            state.location!.name,
                            style: const TextStyle(fontSize: 20),
                          ),
                          gapW12,
                          Text((state.location!.rating).toString()),
                          const Icon(
                            Icons.star,
                            color: AppColors.yellow,
                          ),
                          const Spacer(),
                          IconButton(
                            icon: Icon(
                              state.location!.isFavorite ?? false
                                  ? Icons.star
                                  : Icons.star_border,
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
                    Expanded(
                      child: Container(
                        color: AppColors.charcoalGrey,
                        child: Column(
                          children: [
                            TabBar(
                              controller: tabController,
                              tabs: const [
                                Tab(
                                  text: 'Localização',
                                ),
                                Tab(
                                  text: 'Informações',
                                ),
                                Tab(
                                  text: 'Horário',
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
                                physics: const NeverScrollableScrollPhysics(),
                                children: [
                                  LocationTab(
                                    id: state.location!.id,
                                  ),
                                  const InformationTab(),
                                  const Text('Horário'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
      },
    );
  }
}
