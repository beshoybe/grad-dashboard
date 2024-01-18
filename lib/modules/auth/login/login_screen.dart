import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grad_dashboard/modules/auth/login/provider/login_provider.dart';
import 'package:grad_dashboard/modules/auth/login/provider/login_states.dart';
import 'package:grad_dashboard/routes.dart';
import 'package:grad_dashboard/shared/extensions.dart';
import 'package:grad_dashboard/shared/images.dart';
import 'package:grad_dashboard/shared/strings.dart';
import 'package:grad_dashboard/shared/widgets/input_field.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(loginProvider.notifier);
    final state = ref.watch(loginProvider);
    ref.listen(loginProvider, (previous, next) {
      if (next is LoginSuccessState) {
        Navigator.of(context).pushReplacementNamed(AppRoutes.home);
      } else if (next is LoginErrorState) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Theme.of(context).colorScheme.error,
          content: Text(next.error),
        ));
      }
    });
    return Scaffold(
      body: Row(
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
            child: Form(
              key: provider.formKey,
              child: SingleChildScrollView(
                child: SizedBox(
                  height: context.height,
                  child: Padding(
                    padding: EdgeInsets.all(context.radius(2)),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(AppStrings.loginText,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              )),
                          Text(AppStrings.loginDescriptionText,
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).colorScheme.secondary,
                              )),
                          SizedBox(height: context.heightPercent(5)),
                          InputField(
                            label: AppStrings.emailText,
                            hint: AppStrings.emailHintText,
                            controller: provider.emailController,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: context.heightPercent(2)),
                          InputField(
                            label: AppStrings.passwordText,
                            hint: AppStrings.passwordHintText,
                            obscureText: provider.obscureText,
                            controller: provider.passwordController,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                            suffixIcon: IconButton(
                              onPressed: provider.changePasswordVisibility,
                              icon: Icon(provider.obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),
                          ),
                          SizedBox(height: context.heightPercent(2)),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      context.radius(0.5)),
                                ),
                              ),
                              onPressed: () {
                                provider.login();
                              },
                              child: state is LoginLoadingState
                                  ? const Center(
                                      child:
                                          CircularProgressIndicator.adaptive(),
                                    )
                                  : const Text(AppStrings.loginButtonText),
                            ),
                          ),
                        ]),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
