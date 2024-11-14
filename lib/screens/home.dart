import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:zaccount/pages/activities.dart";
import "package:zaccount/pages/dashboard.dart";
import "package:zaccount/pages/my_business.dart";
import "package:zaccount/pages/setting.dart";
import "package:zaccount/presentation/providers/home_provider.dart";

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int currentPageIndex = 0;
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysShow;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        const Dashboard(),
        const MyBusiness(),
        const ActivitiesPage(),
        SettingsPage(),
      ][ref.watch(homeProvider)],
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        labelBehavior: labelBehavior,
        selectedIndex: ref.watch(homeProvider),
        onDestinationSelected: (int index) {
          ref.read(homeProvider.notifier).updateCurrentTab(index);
        },
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.grid_view_rounded),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(CupertinoIcons.graph_circle),
            label: 'My Business',
          ),
          NavigationDestination(
            icon: Icon(Icons.search),
            label: 'Activities',
          ),
          NavigationDestination(
            icon: Icon(CupertinoIcons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
