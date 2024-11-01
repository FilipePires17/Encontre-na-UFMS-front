import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common_widgets/custom_app_bar.dart';
import '../../../../core/constants/keys/route_names.dart';
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
  late final LocationBloc locationBloc;
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    sectionBloc = BlocProvider.of<SectionBloc>(context);
    locationBloc = BlocProvider.of<LocationBloc>(context);
    locationBloc.add(GetLocationEvent(widget.id));

    sectionBloc.add(GetSectionEvent(
      id: widget.id,
      section: EnumSections.localization,
    ));

    _pageController.addListener(() {
      int nextPage = _pageController.page!.round();
      if (_currentPage != nextPage) {
        _currentPage = nextPage;
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocationBloc, LocationState>(
      listener: (context, state) {
        if (state.status == LocationStateStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error ?? ''),
            ),
          );
        } else if (state.status == LocationStateStatus.unauthorized) {
          Navigator.of(context).pushNamed(
            RouteNames.login,
            arguments: true,
          );
        }
      },
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
                      onPressed: () {
                        locationBloc.add(ToggleFavoriteEvent(widget.id));
                      },
                    ),
                  ],
                ),
                body: Column(
                  children: [
                    Container(
                      color: AppColors.charcoalGrey,
                      height: 200,
                      width: double.infinity,
                      child: Stack(
                        children: [
                          state.location!.multimedia.isEmpty
                              ? const Center(child: Icon(Icons.image))
                              : PageView.builder(
                                  controller: _pageController,
                                  itemCount: state.location!.multimedia.length,
                                  itemBuilder: (_, index) => Image.memory(
                                    state.location!.multimedia[index].media,
                                    fit: BoxFit.contain,
                                    errorBuilder: (_, __, ___) {
                                      return const Center(
                                        child: Icon(Icons.image_not_supported),
                                      );
                                    },
                                  ),
                                ),
                          if (state.location!.multimedia.length > 1)
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  state.location!.multimedia.length,
                                  (index) {
                                    return AnimatedContainer(
                                      duration: const Duration(
                                        milliseconds: 300,
                                      ),
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 4.0,
                                      ),
                                      height: 12.0,
                                      width: _currentPage == index ? 12.0 : 8.0,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: _currentPage == index
                                            ? AppColors.primary
                                            : Colors.grey,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    Container(
                      height: 80,
                      padding:
                          const EdgeInsets.symmetric(horizontal: Sizes.p16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            state.location!.name,
                            style: const TextStyle(
                              fontSize: 20,
                              overflow: TextOverflow.ellipsis,
                            ),
                            maxLines: 1,
                          ),
                          Row(
                            children: [
                              if (state.location!.hasAccessibility) ...[
                                Container(
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(Sizes.p4),
                                    ),
                                    color: AppColors.primary,
                                  ),
                                  child: const Icon(
                                    Icons.accessible,
                                    color: AppColors.white,
                                  ),
                                ),
                                const Text(' - ')
                              ],
                              Text((state.location!.rating ?? 0).toString()),
                              const Icon(
                                Icons.star,
                                color: AppColors.yellow,
                                size: Sizes.p16,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      color: AppColors.black,
                      height: 1,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          TabBar(
                            indicatorColor: AppColors.primary,
                            labelColor: AppColors.primary,
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
                              Tab(text: 'Localização'),
                              Tab(text: 'Informações'),
                              Tab(text: 'Horário'),
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
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: [
                                    state.status == SectionStateStatus.loading
                                        ? const Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : state.section is LocalizationSection
                                            ? LocationTab(
                                                localizationSection:
                                                    state.section
                                                        as LocalizationSection,
                                                locationId: widget.id,
                                              )
                                            : const SizedBox(),
                                    state.status == SectionStateStatus.loading
                                        ? const Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : state.section is MoreInfoSection
                                            ? InformationTab(
                                                moreInfoSection: state.section
                                                    as MoreInfoSection,
                                              )
                                            : const SizedBox(),
                                    state.status == SectionStateStatus.loading
                                        ? const Center(
                                            child: CircularProgressIndicator(),
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
                    )
                  ],
                ),
              );
      },
    );
  }
}
