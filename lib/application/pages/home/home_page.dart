import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/application/core/page_config.dart';
import 'package:todo_app/application/pages/dashboard/dashboard_page.dart';
import 'package:todo_app/application/pages/detail/todo_detail_page.dart';
import 'package:todo_app/application/pages/home/bloc/cubit/navigation_todo_cubit.dart';
import 'package:todo_app/application/pages/overview/overview_page.dart';
import 'package:todo_app/application/pages/settings/settings_page.dart';

class HomePageProvider extends StatelessWidget {
  const HomePageProvider({
    super.key,
    required this.tab,
  });

  final String tab;

  @override
  Widget build(BuildContext context) {
    return HomePage(
      tab: tab,
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({
    super.key,
    required String tab,
  }) : index = tabs.indexWhere(
          (element) => element.name == tab,
        );

  static const tabs = [
    DashboardPage.pageConfig,
    OverviewPage.pageConfig,
  ];

  final int index;

  static const pageConfig = PageConfig(
    icon: Icons.home_rounded,
    name: 'home',
  );

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final destinations = HomePage.tabs
      .map(
        (page) => NavigationDestination(
          icon: Icon(page.icon),
          label: page.name,
        ),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: BlocListener<NavigationToDoCubit, NavigationToDoCubitState>(
          listener: (context, state) {
            if (context.canPop() && (state.isSecondBodyDisplayed ?? false)) {
              context.pop();
            }
          },
          listenWhen: (previous, current) =>
              previous.isSecondBodyDisplayed != current.isSecondBodyDisplayed,
          child: AdaptiveLayout(
            primaryNavigation: SlotLayout(
              config: <Breakpoint, SlotLayoutConfig>{
                Breakpoints.mediumAndUp: SlotLayout.from(
                  key: const Key('primary-navigation-medium'),
                  builder: (context) => AdaptiveScaffold.standardNavigationRail(
                    trailing: IconButton(
                      key: const Key('open-settings'),
                      onPressed: () =>
                          context.pushNamed(SettingsPage.pageConfig.name),
                      icon: Icon(SettingsPage.pageConfig.icon),
                    ),
                    destinations: destinations
                        .map(
                          (destination) => AdaptiveScaffold.toRailDestination(
                            destination,
                          ),
                        )
                        .toList(),
                    onDestinationSelected: (index) =>
                        _tapOnNavigationDesination(context, index),
                    selectedIndex: widget.index,
                    selectedLabelTextStyle: TextStyle(
                      color: theme.colorScheme.onBackground,
                    ),
                    selectedIconTheme: IconThemeData(
                      color: theme.colorScheme.onBackground,
                    ),
                    unselectedIconTheme: IconThemeData(
                      color: theme.colorScheme.onBackground.withOpacity(0.5),
                    ),
                  ),
                ),
              },
            ),
            bottomNavigation: SlotLayout(
              config: <Breakpoint, SlotLayoutConfig>{
                Breakpoints.small: SlotLayout.from(
                  key: const Key('bottom-navigation-small'),
                  builder: (_) => AdaptiveScaffold.standardBottomNavigationBar(
                    destinations: destinations,
                    currentIndex: widget.index,
                    onDestinationSelected: (value) =>
                        _tapOnNavigationDesination(context, value),
                  ),
                ),
              },
            ),
            body: SlotLayout(
              config: <Breakpoint, SlotLayoutConfig>{
                Breakpoints.smallAndUp: SlotLayout.from(
                  key: const Key('primary-body-small'),
                  builder: (_) => HomePage.tabs[widget.index].child,
                ),
              },
            ),
            secondaryBody: SlotLayout(
              config: <Breakpoint, SlotLayoutConfig>{
                Breakpoints.mediumAndUp: SlotLayout.from(
                  key: const Key('secondary-body-medium'),
                  builder: widget.index != 1
                      ? null
                      : (_) => BlocBuilder<NavigationToDoCubit,
                              NavigationToDoCubitState>(
                            builder: (context, state) {
                              final selectedId = state.selectedCollectionId;
                              final isSecondBodyDisplayed =
                                  Breakpoints.mediumAndUp.isActive(context);
                              context
                                  .read<NavigationToDoCubit>()
                                  .secondBodyHasChanged(
                                    isSecondBodyDisplayed:
                                        isSecondBodyDisplayed,
                                  );

                              if (selectedId == null) {
                                return Container();
                              } else {
                                return ToDoDetailPageProvider(
                                  key: Key(
                                    selectedId.value,
                                  ),
                                  collectionId: selectedId,
                                );
                              }
                            },
                          ),
                ),
              },
            ),
          ),
        ),
      ),
    );
  }

  void _tapOnNavigationDesination(BuildContext context, int index) =>
      context.goNamed(
        HomePage.pageConfig.name,
        pathParameters: {
          'tab': HomePage.tabs[index].name,
        },
      );
}
