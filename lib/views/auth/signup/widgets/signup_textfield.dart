import 'package:flutter/material.dart';
import '../../../../constants/app_size.dart';
import '../../../../constants/color_constant.dart';

Column buildSignUpTextField({
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
          obscureText: obscure,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            label: Text(hint),
            hintText: hint,
            suffixIcon: suffixIcon,
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
      ],
    );
