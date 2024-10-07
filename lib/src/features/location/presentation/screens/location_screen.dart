import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common_widgets/custom_app_bar.dart';
import '../../../../core/constants/sizes/app_sizes.dart';
import '../../../../core/constants/theme/app_colors.dart';
import '../../domain/entities/sections.dart';
import '../../domain/enums/enum_sections.dart';
import '../bloc/location/location_bloc.dart';
import '../bloc/section/section_bloc.dart';
import '../widgets/hours_tab.dart';
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
  late SectionBloc sectionBloc;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    sectionBloc = BlocProvider.of<SectionBloc>(context);
    sectionBloc.add(GetSectionEvent(
      id: widget.id,
      section: EnumSections.localization,
    ));
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
                  actions: [
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
                              onTap: (value) {
                                int section = value;
                                if (section == 1) {
                                  section = 2;
                                } else if (section == 2) {
                                  section = 1;
                                }
                                sectionBloc.add(GetSectionEvent(
                                  id: widget.id,
                                  section: EnumSections.values[section],
                                ));
                              },
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
                            BlocBuilder<SectionBloc, SectionState>(
                              builder: (context, state) {
                                return Expanded(
                                  child: TabBarView(
                                    controller: tabController,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    children: [
                                      state.status == SectionStateStatus.loading
                                          ? const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                          : state.section is LocalizationSection
                                              ? LocationTab(
                                                  localizationSection: state
                                                          .section
                                                      as LocalizationSection,
                                                )
                                              : const SizedBox(),
                                      state.status == SectionStateStatus.loading
                                          ? const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                          : state.section is MoreInfoSection
                                              ? InformationTab(
                                                  moreInfoSection: state.section
                                                      as MoreInfoSection,
                                                )
                                              : const SizedBox(),
                                      state.status == SectionStateStatus.loading
                                          ? const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                          : state.section is HoursSection
                                              ? HoursTab(
                                                  hoursSection: state.section
                                                      as HoursSection,
                                                )
                                              : const SizedBox(),
                                    ],
                                  ),
                                );
                              },
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
