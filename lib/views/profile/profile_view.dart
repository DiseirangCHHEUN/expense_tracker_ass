import 'package:expense_tracker/constants/app_size.dart';
import 'package:expense_tracker/constants/color_constant.dart';
import 'package:expense_tracker/constants/style_constant.dart';
import 'package:expense_tracker/utils/custom_appbar.dart';
import 'package:expense_tracker/views/setting/controller/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        title: 'profile',
        leading: const BackButton(),
        actions: const SizedBox(),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.p20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: AppSizes.s28,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  maxRadius: AppSizes.s20 * 2,
                ),
              ],
            ),
            SizedBox(
              height: AppSizes.s28,
            ),
            Text('Email'),
            UserInfo(
              text: 'Someone@gmail.com',
            ),
            SizedBox(
              height: AppSizes.s10,
            ),
            Text('Phone'),
            UserInfo(
              text: '0123456789',
            ),
            Expanded(
              child: SizedBox(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: FilledButton.icon(
        onPressed: () {},
        label: const Text(
          'Logout',
          style: TextStyleConstant.kSmallTitleTextStyle,
        ),
        icon: const Icon(Icons.logout_rounded),
        style: const ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(ColorConstants.kRedColor),
        ),
      ),
    );
  }
}

class UserInfo extends StatelessWidget {
  const UserInfo({
    super.key,
    required this.text,
  });

  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GetBuilder<SettingController>(
            builder: (controller) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.p10,
                  vertical: AppSizes.p8,
                ),
                decoration: BoxDecoration(
                  color: ColorConstants.kGreyColor.withOpacity(.2),
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: controller.isDarkMode
                        ? ColorConstants.kWhiteColor
                        : Colors.black,
                  ),
                ),
                child: Text(text),
              );
            },
          ),
        ),
      ],
    );
  }
}
