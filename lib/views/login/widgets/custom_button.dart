import 'package:expense_tracker/constants/app_size.dart';
import 'package:expense_tracker/constants/color_constant.dart';
import 'package:expense_tracker/constants/style_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.buttonText, required this.icon});

  final String buttonText;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppSizes.p10),
      height: 50,
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.s10),
        color: ColorConstants.kRedColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            buttonText,
            style: TextStyleConstant.kTitleSmallTextStyle,
          ),
          const SizedBox(width: AppSizes.p10),
          Icon(
            icon,
            color: ColorConstants.kWhiteColor,
          ),
        ],
      ),
    );
  }
}
