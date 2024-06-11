import 'package:expense_tracker/constants/app_size.dart';
import 'package:expense_tracker/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

showCustomBottomSheet(BuildContext context, {required String title,required Widget children}) {
  return showCupertinoModalBottomSheet(
    context: context,
    builder: (context) {
      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.p10),
            child: Column(
              children: [
                Text(title.tr),
                Container(
                  height: 8,
                  width: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: ColorConstants.kGreyColor,
                  ),
                ),
                const Divider(thickness: .5),
                children,
              ],
            ),
          ),
        ),
      );
    },
  );
}
