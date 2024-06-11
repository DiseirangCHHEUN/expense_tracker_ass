import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/app_size.dart';
import '../constants/color_constant.dart';

Column buildTextField({
  required bool obscure,
  required TextEditingController controller,
  required Widget suffixIcon,
  required TextInputType keyboardType,
  required String hint,
}) =>
    Column(
      children: [
        const SizedBox(height: AppSizes.p10),
        TextField(
          onSubmitted: (value) {},
          controller: controller,
          obscureText: obscure,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            filled: true,
            fillColor: ColorConstants.kGreyColor.withOpacity(.5),
            label: Text(hint.tr),
            hintText: hint.tr,
            suffixIcon: suffixIcon,
            suffixIconColor: ColorConstants.kYellowColor,
            prefixIconColor: Colors.black,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                strokeAlign: AppSizes.p10,
                width: 1,
                style: BorderStyle.solid,
                color: ColorConstants.kYellowColor.withOpacity(.5),
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(AppSizes.p8),
              ),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                style: BorderStyle.solid,
                color: ColorConstants.kYellowColor.withOpacity(.3),
                width: 1,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(AppSizes.p8),
              ),
            ),
          ),
        ),
      ],
    );
