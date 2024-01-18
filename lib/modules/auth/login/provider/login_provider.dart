import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grad_dashboard/modules/auth/login/provider/login_states.dart';

final loginProvider = StateNotifierProvider<LoginProvider, LoginStates>(
  (ref) => LoginProvider(),
);

class LoginProvider extends StateNotifier<LoginStates> {
  LoginProvider() : super(LoginInitialState());

  bool obscureText = true;
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void changePasswordVisibility() {
    obscureText = !obscureText;
    state = LoginChangePasswordVisibilityState();
  }

  Future<void> login() async {
    if (state is LoginLoadingState) {
      return;
    }
    state = LoginLoadingState();
    if (formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        final user = FirebaseFirestore.instance
            .collection('admins')
            .doc(FirebaseAuth.instance.currentUser!.uid);
        final userData = await user.get();
        if (!userData.exists) {
          state = LoginErrorState('Invalid email or password');
          return;
        }
        state = LoginSuccessState();
      } on FirebaseAuthException catch (e) {
        print(e.message);
        if (e.code == 'invalid-credential') {
          state = LoginErrorState('Invalid email or password');
        }
      }
    } else {
      state = LoginValidateState();
    }
  }
}
