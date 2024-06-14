import 'package:expense_tracker/constants/app_size.dart';
import 'package:expense_tracker/constants/color_constant.dart';
import 'package:expense_tracker/constants/style_constant.dart';
import 'package:expense_tracker/utils/custom_button.dart';
import 'package:expense_tracker/views/auth/controller/auth_controller.dart';
import 'package:expense_tracker/views/auth/login/login_view.dart';
import 'package:expense_tracker/views/auth/login/widgets/login_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final currentPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: AppSizes.s28 * 3),
                const Text(
                  'Create an account',
                  style: TextStyleConstant.kTitleTextStyle,
                ),
                Padding(
                  padding: const EdgeInsets.all(AppSizes.p16),
                  child: Stack(
                    children: [
                      GetBuilder<AuthController>(
                        builder: (context) {
                          return CircleAvatar(
                            maxRadius: Get.width * .14,
                            backgroundColor: ColorConstants.kRedColor,
                            backgroundImage: authController.imageFile == null
                                ? null
                                : FileImage(authController.imageFile!),
                            child: authController.imageFile == null
                                ? const Icon(
                                    Icons.person_rounded,
                                    size: AppSizes.s24 * 1.8,
                                    color: ColorConstants.kWhiteColor,
                                  )
                                : null,
                          );
                        },
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: authController.pickGalleryImage,
                          child: const CircleAvatar(
                            backgroundColor: ColorConstants.kRedColor,
                            child: Icon(
                              Icons.camera_alt_rounded,
                              color: ColorConstants.kWhiteColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
                buildLoginTextField(
                  hint: 'Enter phone number',
                  obscure: false,
                  keyboardType: TextInputType.phone,
                  prefixIcon: const Icon(Icons.phone),
                  suffixIcon: const SizedBox(),
                  onChanged: (value) {
                    authController.phoneNumber.value = value;
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
                const SizedBox(height: AppSizes.p10),
                Obx(() {
                  return buildLoginTextField(
                    hint: 'Enter current password',
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
                      authController.currentPassword.value = value;
                    },
                  );
                }),
                SizedBox(height: 20),
                CustomButton(
                  onPress: () {
                    authController.register(
                      authController.email.value.trim(),
                      authController.password.value.trim(),
                      authController.currentPassword.value.trim(),
                      authController.phoneNumber.value.trim(),
                    );
                  },
                  buttonText: 'Sign Up',
                  icon: Icons.login_rounded,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Wrap(
                      children: [
                        const Text("Don't have an account?"),
                        const SizedBox(width: AppSizes.p8),
                        GestureDetector(
                          onTap: () => Get.off(
                            () => LoginPage(),
                            transition: Transition.fade,
                            duration: const Duration(milliseconds: 300),
                          ),
                          child: Text(
                            "Sign in",
                            style: TextStyle(
                              color: ColorConstants.kRedColor.withOpacity(.8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
