import 'package:expense_tracker/constants/app_size.dart';
import 'package:expense_tracker/constants/color_constant.dart';
import 'package:expense_tracker/views/login/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'widgets/custom_textfield.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwdController = TextEditingController();

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
              buildTextField(
                  hint: 'Enter email address',
                  obscure: false,
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(Icons.email_rounded),
                  suffixIcon: const SizedBox()),
              const SizedBox(height: AppSizes.p10),
              buildTextField(
                  hint: 'Enter password',
                  obscure: true,
                  controller: pwdController,
                  keyboardType: TextInputType.visiblePassword,
                  prefixIcon: const Icon(Icons.lock_outline_rounded),
                  suffixIcon: const Icon(Icons.visibility_rounded)),
              const SizedBox(height: AppSizes.p10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Forgot Password?'),
                ],
              ),
              const CustomButton(
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
                      Text(
                        "Register",
                        style: TextStyle(
                          color: ColorConstants.kRedColor.withOpacity(.8),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
