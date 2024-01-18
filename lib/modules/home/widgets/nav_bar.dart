import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grad_dashboard/modules/home/provider/home_provider.dart';
import 'package:grad_dashboard/modules/home/widgets/header.dart';
import 'package:grad_dashboard/routes.dart';
import 'package:grad_dashboard/shared/extensions.dart';

class HomeNavBar extends ConsumerWidget {
  const HomeNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(homeProvider.notifier);
    final selectedIndex = provider.selectedTabIndex;
    ref.watch(homeProvider);
    return Container(
      height: double.infinity,
      color: Theme.of(context).colorScheme.primary,
      width: context.widthPercent(20),
      child: Column(
        children: [
          const HomeHeader(
            showMenu: false,
          ),
          Container(
            margin: EdgeInsets.all(context.radius(0.5)),
            color: selectedIndex != 0
                ? Theme.of(context).colorScheme.primary
                : Colors.white,
            child: ListTile(
              textColor: selectedIndex == 0
                  ? Theme.of(context).colorScheme.primary
                  : Colors.white,
              iconColor: selectedIndex == 0
                  ? Theme.of(context).colorScheme.primary
                  : Colors.white,
              selected: selectedIndex == 0,
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                provider.changeSelectedTab(0);
              },
            ),
          ),
          Container(
            margin: EdgeInsets.all(context.radius(0.5)),
            color: selectedIndex != 1
                ? Theme.of(context).colorScheme.primary
                : Colors.white,
            child: ListTile(
              textColor: selectedIndex == 1
                  ? Theme.of(context).colorScheme.primary
                  : Colors.white,
              iconColor: selectedIndex == 1
                  ? Theme.of(context).colorScheme.primary
                  : Colors.white,
              selected: selectedIndex == 1,
              leading: const Icon(Icons.person),
              title: const Text('Users'),
              onTap: () {
                provider.changeSelectedTab(1);
              },
            ),
          ),
          Container(
            margin: EdgeInsets.all(context.radius(0.5)),
            color: selectedIndex != 2
                ? Theme.of(context).colorScheme.primary
                : Colors.white,
            child: ListTile(
              textColor: selectedIndex == 2
                  ? Theme.of(context).colorScheme.primary
                  : Colors.white,
              iconColor: selectedIndex == 2
                  ? Theme.of(context).colorScheme.primary
                  : Colors.white,
              selected: selectedIndex == 2,
              leading: const Icon(Icons.bike_scooter),
              title: const Text('Bikes'),
              onTap: () {
                provider.changeSelectedTab(2);
              },
            ),
          ),
          const Spacer(),
          Container(
            margin: EdgeInsets.all(context.radius(0.5)),
            color: selectedIndex != 3
                ? Theme.of(context).colorScheme.primary
                : Colors.white,
            child: ListTile(
              textColor: selectedIndex == 3
                  ? Theme.of(context).colorScheme.primary
                  : Colors.white,
              iconColor: selectedIndex == 3
                  ? Theme.of(context).colorScheme.primary
                  : Colors.white,
              selected: selectedIndex == 3,
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, AppRoutes.login, (route) => false);
              },
            ),
          ),
        ],
      ),
    );
  }
}
