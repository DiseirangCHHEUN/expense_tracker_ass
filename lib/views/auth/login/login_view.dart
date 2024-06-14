import 'package:expense_tracker/constants/app_size.dart';
import 'package:expense_tracker/constants/color_constant.dart';
import 'package:expense_tracker/utils/custom_button.dart';
import 'package:expense_tracker/views/auth/controller/auth_controller.dart';
import 'package:expense_tracker/views/auth/login/widgets/login_textfield.dart';
import 'package:expense_tracker/views/auth/signup/signup_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 160),
              Image.asset(
                'assets/logo.png',
                height: 120,
                width: 120,
              ),
              const SizedBox(height: AppSizes.s24),
              const Text('Welcome back to Login Screen',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  )),
              const Text(
                'Tracking your expenses and incomes here.',
                style: TextStyle(
                  fontSize: AppSizes.s12,
                ),
              ),
              const SizedBox(height: AppSizes.s20),
              buildLoginTextField(
                hint: 'Enter email address',
                obscure: false,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: const Icon(Icons.email_rounded),
                suffixIcon: const SizedBox(),
                onChanged: (value) {
                  authController.email.value = value;
                },
              ),
              const SizedBox(height: AppSizes.p10),
              Obx(() {
                return buildLoginTextField(
                  hint: 'Enter password',
                  obscure: authController.isPwdVisibility.value,
                  keyboardType: TextInputType.visiblePassword,
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: GestureDetector(
                    onTap: authController.toggleShowPwd,
                    child: Icon(
                      authController.isPwdVisibility.value
                          ? Icons.visibility_off_rounded
                          : Icons.visibility_rounded,
                    ),
                  ),
                  onChanged: (value) {
                    authController.password.value = value;
                  },
                );
              }),
              const SizedBox(height: 5),
              GestureDetector(
                onTap: () {
                  // Initiate password reset process
                  authController
                      .resetPassword(authController.email.value.trim());
                },
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    "Forgot password?",
                    style: TextStyle(
                      color: ColorConstants.kRedColor.withOpacity(.8),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              CustomButton(
                onPress: () {
                  authController.login(
                    authController.email.value.trim(),
                    authController.password.value.trim(),
                  );
                },
                buttonText: 'Sign in',
                icon: Icons.login_rounded,
              ),
              const SizedBox(height: AppSizes.p20),
              const SizedBox(height: AppSizes.p8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  const SizedBox(width: AppSizes.p8),
                  GestureDetector(
                    onTap: () => Get.off(
                      () => RegisterPage(),
                      transition: Transition.fade,
                      duration: const Duration(milliseconds: 300),
                    ),
                    child: Text(
                      "Sign up",
                      style: TextStyle(
                        color: ColorConstants.kRedColor.withOpacity(.8),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
