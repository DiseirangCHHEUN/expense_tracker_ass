import 'package:expense_tracker/constants/app_size.dart';
import 'package:expense_tracker/constants/color_constant.dart';
import 'package:expense_tracker/views/auth/signup/signup_view.dart';
import 'package:expense_tracker/views/category/category_view.dart';
import 'package:expense_tracker/views/auth/controller/auth_controller.dart';
import 'package:expense_tracker/utils/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widgets/login_textfield.dart';

class LoginView extends GetView<AuthController> {
  LoginView({super.key});
  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.p20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSizes.s28 * 3),
              Image.asset(
                'assets/logo.png',
                height: 120,
                width: 120,
              ),
              const SizedBox(height: AppSizes.s24),
              const Text(
                'Welcome back to Login Screen',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: AppSizes.s18,
                ),
              ),
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
                  controller: _authController.emailLoginController,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(Icons.email_rounded),
                  suffixIcon: const SizedBox()),
              const SizedBox(height: AppSizes.p10),
              GetBuilder<AuthController>(
                builder: (context) {
                  return buildLoginTextField(
                    hint: 'Enter password',
                    obscure: _authController.isPwdVisibility,
                    controller: _authController.pwdLoginController,
                    keyboardType: TextInputType.visiblePassword,
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: GestureDetector(
                      onTap: _authController.toggleShowPwd,
                      child: Icon(
                        _authController.isPwdVisibility
                            ? Icons.visibility_off_rounded
                            : Icons.visibility_rounded,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: AppSizes.p10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Forgot Password?'),
                ],
              ),
              CustomButton(
                onPress: () => Get.to(
                  () => const CategoryView(),
                  transition: Transition.cupertino,
                  duration: const Duration(milliseconds: 300),
                ),
                buttonText: 'Login',
                icon: Icons.login_rounded,
              ),
              const SizedBox(height: AppSizes.p20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Wrap(
                    children: [
                      const Text("Don't have an account?"),
                      const SizedBox(width: AppSizes.p8),
                      GestureDetector(
                        onTap: () => Get.off(
                          () => SignupView(),
                          transition: Transition.fade,
                          duration: const Duration(milliseconds: 300),
                        ),
                        child: Text(
                          "Register",
                          style: TextStyle(
                            color: ColorConstants.kRedColor.withOpacity(.8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: AppSizes.s28),
            ],
          ),
        ),
      ),
    );
  }
}
