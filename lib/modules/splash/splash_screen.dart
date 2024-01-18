import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grad_dashboard/modules/splash/provider/splash_provider.dart';
import 'package:grad_dashboard/modules/splash/provider/splash_states.dart';
import 'package:grad_dashboard/routes.dart';
import 'package:grad_dashboard/shared/extensions.dart';
import 'package:grad_dashboard/shared/images.dart';
import 'package:grad_dashboard/shared/strings.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(splashProvider.notifier);
    ref.watch(splashProvider);
    ref.listen(splashProvider, (previous, next) {
      if (next is SplashAuthenticatedState) {
        Navigator.of(context).pushReplacementNamed(AppRoutes.home);
      } else if (next is SplashUnAuthenticatedState) {
        Navigator.of(context).pushReplacementNamed(AppRoutes.login);
      }
    });
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(context.radius(1)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(context.radius(2)),
                child: Image.asset(
                  AppImages.bike,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppStrings.splashFirstText,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary)),
                  SizedBox(height: context.heightPercent(1)),
                  Text(AppStrings.splashSecondText,
                      style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.secondary)),
                  SizedBox(height: context.heightPercent(5)),
                  Center(
                    child: ElevatedButton(
                        onPressed: provider.checkAuthenticated,
                        child: const Text(AppStrings.continueText)),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
