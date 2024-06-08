import 'package:expense_tracker/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/style_constant.dart';

class SettingListTile extends StatelessWidget {
  const SettingListTile({
    super.key,
    required this.title,
    required this.trailing,
    required this.onTap,
    required this.leading,
  });
  final Widget leading, trailing;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        iconColor: ColorConstants.kWhiteColor,
        leading: leading,
        title: Text(
          title.tr,
          textAlign: TextAlign.left,
          style: TextStyleConstant.kTitleSmallTextStyle,
        ),
        trailing: trailing,
      ),
    );
  }
}
