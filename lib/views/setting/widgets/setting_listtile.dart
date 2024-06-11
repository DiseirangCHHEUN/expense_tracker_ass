import 'package:expense_tracker/views/setting/controller/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/color_constant.dart';

class SettingListTile extends StatelessWidget {
  const SettingListTile({
    super.key,
    required this.title,
    required this.trailing,
    required this.onTap,
    required this.leading,
    required this.subtitle,
  });
  final Widget leading, trailing;
  final String title, subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: ListTile(
          leading: leading,
          title: Text(
            title.tr,
            textAlign: TextAlign.left,
          ),
          subtitle: GetBuilder<SettingController>(
            builder: (controller) {
              return Text(
                subtitle.tr,
                style: TextStyle(
                  color: title == 'profile'
                      ? null
                      : controller.isDarkMode
                          ? ColorConstants.kYellowColor
                          : ColorConstants.kRedColor,
                ),
              );
            }
          ),
          trailing: trailing,
        ),
      ),
    );
  }
}

class LanguageListTile extends StatelessWidget {
  const LanguageListTile({
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
      child: Card(
        child: ListTile(
          // iconColor: ColorConstants.kWhiteColor,
          leading: leading,
          title: Text(
            title.tr,
            textAlign: TextAlign.left,
            // style: TextStyleConstant.kTitleSmallTextStyle,
          ),
          trailing: trailing,
        ),
      ),
    );
  }
}
