import 'package:expense_tracker/constants/style_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/app_size.dart';
import '../../../constants/color_constant.dart';
import '../../../utils/custom_button.dart';
import '../../category/category_view.dart';
import '../controller/auth_controller.dart';
import 'widgets/signup_textfield.dart';

class SignupView extends StatelessWidget {
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
                          backgroundColor:
                              ColorConstants.kRedColor.withOpacity(.8),
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
                        child: CircleAvatar(
                          backgroundColor:
                              ColorConstants.kRedColor.withOpacity(.8),
                          child: const Icon(
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
                  controller: _authController.emailController,
                  keyboardType: TextInputType.name,
                  suffixIcon: const SizedBox()),
              buildSignUpTextField(
                  hint: 'Enter email address',
                  obscure: false,
                  controller: _authController.emailController,
                  keyboardType: TextInputType.emailAddress,
                  suffixIcon: const SizedBox()),
              buildSignUpTextField(
                  hint: 'Enter phone number',
                  obscure: false,
                  controller: _authController.emailController,
                  keyboardType: TextInputType.phone,
                  suffixIcon: const SizedBox()),
              buildSignUpTextField(
                hint: 'Enter password',
                obscure: _authController.isPwdVisibility.value,
                controller: _authController.pwdController,
                keyboardType: TextInputType.visiblePassword,
                suffixIcon: const SizedBox(),
              ),
              buildSignUpTextField(
                hint: 'confirm password',
                obscure: _authController.isPwdVisibility.value,
                controller: _authController.pwdController,
                keyboardType: TextInputType.visiblePassword,
                suffixIcon: const SizedBox(),
              ),
              CustomButton(
                onPress: () => Get.to(
                  () => const CategoryView(),
                  transition: Transition.cupertino,
                  duration: const Duration(milliseconds: 300),
                ),
                buttonText: 'Register',
                icon: Icons.login_rounded,
              ),
              const SizedBox(height: AppSizes.p20),
              GestureDetector(
                onTap: () => Get.off(
                  () => SignupView(),
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
