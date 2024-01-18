import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grad_dashboard/modules/home/provider/home_provider.dart';
import 'package:grad_dashboard/modules/home/screens/bikes/bikes_tab.dart';
import 'package:grad_dashboard/modules/home/screens/home_tab.dart';
import 'package:grad_dashboard/modules/home/screens/users/users_tab.dart';
import 'package:grad_dashboard/modules/home/widgets/nav_bar.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(homeProvider.notifier);
    ref.watch(homeProvider);
    final tabsList = <Widget>[
      const HomeTab(),
      const UsersTab(),
      const BikesTab()
    ];
    ref.watch(homeProvider);
    return Scaffold(
        body: SafeArea(
      child: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Row(
          children: [
            const HomeNavBar(),
            Expanded(child: tabsList[provider.selectedTabIndex])
          ],
        ),
      ),
    ));
  }
}
