import 'package:expense_tracker/constants/style_constant.dart';
import 'package:expense_tracker/views/auth/login/login_view.dart';
import 'package:expense_tracker/views/dashboard/dashboard_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/app_size.dart';
import '../../../constants/color_constant.dart';
import '../../../utils/custom_button.dart';
import '../controller/auth_controller.dart';
import 'widgets/signup_textfield.dart';

class SignupView extends GetView<AuthController> {
  SignupView({super.key});
  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.p20),
          child: Column(
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
                          backgroundImage: _authController.imageFile == null
                              ? null
                              : FileImage(_authController.imageFile!),
                          child: _authController.imageFile == null
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
                        onTap: _authController.pickGalleryImage,
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
              buildSignUpTextField(
                  hint: 'Enter username',
                  obscure: false,
                  controller: _authController.usernameSignupController,
                  keyboardType: TextInputType.name,
                  suffixIcon: const SizedBox()),
              buildSignUpTextField(
                  hint: 'Enter email address',
                  obscure: false,
                  controller: _authController.emailSignupController,
                  keyboardType: TextInputType.emailAddress,
                  suffixIcon: const SizedBox()),
              buildSignUpTextField(
                  hint: 'Enter phone number',
                  obscure: false,
                  controller: _authController.phoneSignupController,
                  keyboardType: TextInputType.phone,
                  suffixIcon: const SizedBox()),
              buildSignUpTextField(
                hint: 'Enter password',
                obscure: true,
                controller: _authController.pwdSignupController,
                keyboardType: TextInputType.visiblePassword,
                suffixIcon: const SizedBox(),
              ),
              buildSignUpTextField(
                hint: 'Confirm password',
                obscure: true,
                controller: _authController.cPwdSignupController,
                keyboardType: TextInputType.visiblePassword,
                suffixIcon: const SizedBox(),
              ),
              CustomButton(
                onPress: () {
                  _authController.clearSignupData();
                  Get.to(
                    () => DashboardView(),
                    transition: Transition.zoom,
                    duration: const Duration(milliseconds: 300),
                  );
                },
                buttonText: 'Register',
                icon: Icons.login_rounded,
              ),
              const SizedBox(height: AppSizes.p20),
              GestureDetector(
                onTap: () => Get.off(
                  () => LoginView(),
                  transition: Transition.fade,
                  duration: const Duration(milliseconds: 300),
                ),
                child: Text(
                  "Already have an account? Login",
                  style: TextStyle(
                    color: ColorConstants.kRedColor.withOpacity(.6),
                  ),
                ),
              ),
              const SizedBox(height: AppSizes.s28),
            ],
          ),
        ),
      ),
    );
  }
}
