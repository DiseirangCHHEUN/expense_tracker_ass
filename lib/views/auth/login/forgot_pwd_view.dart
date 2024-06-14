import 'package:expense_tracker/constants/app_size.dart';
import 'package:expense_tracker/constants/style_constant.dart';
import 'package:expense_tracker/utils/custom_appbar.dart';
import 'package:expense_tracker/utils/custom_button.dart';
import 'package:expense_tracker/views/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/color_constant.dart';
import 'login_view.dart';

class ForgotPwdView extends StatelessWidget {
  ForgotPwdView({super.key});
  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        title: 'Forgot Password',
        leading: BackButton(
          onPressed: () => Get.back(),
        ),
        actions: const SizedBox(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.p20,
          vertical: AppSizes.p16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Forgot your password?',
              style: TextStyleConstant.kTitleTextStyle,
            ),
            const SizedBox(height: AppSizes.s10),
            const Text(
              'Enter your email below to get a link for reset password.',
            ),
            const SizedBox(height: AppSizes.s20),
            Form(
              key: _authController.frmKey,
              child: TextFormField(
                controller: _authController.textEditingController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isNotEmpty) {
                    if (!value.isEmail) {
                      return 'Invalid email address.';
                    }
                    return null;
                  }
                  return 'Please enter your email address.';
                },
                decoration: InputDecoration(
                  label: const Text('Your email'),
                  hintText: 'Enter your email',
                  suffixIconColor: ColorConstants.kYellowColor,
                  prefixIconColor: Colors.black,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      strokeAlign: AppSizes.p10,
                      width: 1,
                      style: BorderStyle.solid,
                      color: ColorConstants.kGreenColor.withOpacity(.5),
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(AppSizes.p8),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      style: BorderStyle.solid,
                      color: ColorConstants.kGreenColor.withOpacity(.3),
                      width: 1,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(AppSizes.p8),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSizes.s10),
            GetBuilder<AuthController>(
              builder: (context) {
                return Visibility(
                  visible: _authController.isVisible,
                  child: Text(
                    'We have sent you an email with reset password link to ${_authController.email} . Submit again in ${_authController.countDownNumber}s.',
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: AppSizes.s10),
            CustomButton(
              buttonText: 'Submit',
              icon: Icons.send_rounded,
              onPress: _authController.startPwdResetCountDown,
            ),
            const SizedBox(height: AppSizes.p20),
            const RegisterAccount(),
            const SizedBox(height: AppSizes.s28),
          ],
        ),
      ),
    );
  }
}
