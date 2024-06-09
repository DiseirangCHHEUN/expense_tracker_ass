import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_size.dart';
import '../constants/color_constant.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({super.key, required this.children, required this.title});

  final Widget children;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shadowColor: ColorConstants.kWhiteColor,
      elevation: 10,
      insetAnimationCurve: Curves.slowMiddle,
      insetAnimationDuration: const Duration(milliseconds: 500),
      child: Container(
        padding: const EdgeInsets.all(AppSizes.p16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          // color: ColorConstants.kBackgroundColor,
        ),
        child: Wrap(
          children: [
            Center(
              child: Text(
                title.tr,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(thickness: .5),
            children,
          ],
        ),
      ),
    );
  }
}
