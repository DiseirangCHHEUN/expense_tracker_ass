import 'package:flutter/material.dart';
import '../../../constants/app_size.dart';
import '../../../constants/color_constant.dart';

TextField buildTextField({
  required bool obscure,
  required TextEditingController controller,
  required Widget prefixIcon,
  required Widget suffixIcon,
  required TextInputType keyboardType,
  required String hint,
}) =>
    TextField(
      obscureText: obscure,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        suffixIcon: suffixIcon,
        suffixIconColor: ColorConstants.kRedColor.withOpacity(.5),
        prefixIcon: prefixIcon,
        prefixIconColor: Colors.black,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            strokeAlign: AppSizes.p10,
            width: 1,
            style: BorderStyle.solid,
            color: ColorConstants.kGreyColor.withOpacity(.5),
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(AppSizes.s10),
          ),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(AppSizes.s10),
          ),
        ),
      ),
    );
