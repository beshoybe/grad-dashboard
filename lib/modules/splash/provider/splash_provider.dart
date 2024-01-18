import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grad_dashboard/modules/splash/provider/splash_states.dart';

final splashProvider = StateNotifierProvider<SplashProvider, SplashStates>(
  (ref) => SplashProvider(),
);

class SplashProvider extends StateNotifier<SplashStates> {
  SplashProvider() : super(SplashInitialState());

  Future<void> checkAuthenticated() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      state = SplashUnAuthenticatedState();
    } else {
      state = SplashAuthenticatedState();
    }
  }
}
