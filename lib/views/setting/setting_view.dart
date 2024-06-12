import 'package:expense_tracker/constants/app_size.dart';
import 'package:expense_tracker/constants/color_constant.dart';
import 'package:expense_tracker/utils/custom_appbar.dart';
import 'package:expense_tracker/views/auth/controller/auth_controller.dart';
import 'package:expense_tracker/views/category/category_view.dart';
import 'package:expense_tracker/views/setting/controller/setting_controller.dart';
import 'package:expense_tracker/views/wallet/wallet_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import '../../utils/custom_dialog.dart';
import 'widgets/setting_listtile.dart';

class SettingView extends GetView<SettingController> {
  SettingView({super.key});
  final AuthController authController = Get.put(AuthController());
  final SettingController settingController = Get.put(SettingController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingController>(builder: (context) {
      var isDark = settingController.isDarkMode;
      return Scaffold(
        appBar: buildAppBar(
          title: 'setting',
          leading: const SizedBox(),
          actions: const SizedBox(),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.p8, vertical: AppSizes.p18),
          shrinkWrap: true,
          children: [
            SettingListTile(
              title: 'profile',
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
              onTap: () {},
              leading: GetBuilder<AuthController>(
                builder: (controller) {
                  return CircleAvatar(
                    maxRadius: AppSizes.s18,
                    backgroundImage: controller.imageFile == null
                        ? null
                        : FileImage(controller.imageFile!),
                  );
                },
              ),
              subtitle: 'view your profile',
            ),
            SettingListTile(
              title: 'category',
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
              onTap: () => Get.to(
                () => CategoryView(),
                transition: Transition.rightToLeft,
                duration: const Duration(
                  milliseconds: 300,
                ),
              ),
              leading: Icon(
                Icons.category_rounded,
                color: isDark
                    ? ColorConstants.kYellowColor
                    : ColorConstants.kRedColor,
              ),
              subtitle: 'view your category',
            ),
            SettingListTile(
              title: 'wallet',
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
              onTap: () => Get.to(
                () => const WalletView(),
                transition: Transition.upToDown,
                duration: const Duration(milliseconds: 300),
              ),
              leading: Icon(
                Icons.wallet,
                color: isDark
                    ? ColorConstants.kYellowColor
                    : ColorConstants.kRedColor,
              ),
              subtitle: 'usd',
            ),
            GetBuilder<SettingController>(builder: (context) {
              return SettingListTile(
                title: 'language',
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
                onTap: () => Get.dialog(
                  buildChangeLanguageDialog(),
                ),
                leading: Icon(
                  Icons.g_translate_rounded,
                  color: isDark
                      ? ColorConstants.kYellowColor
                      : ColorConstants.kRedColor,
                ),
                subtitle: settingController.isEnglish ? 'english' : 'khmer',
              );
            }),
            GetBuilder<SettingController>(builder: (context) {
              return SettingListTile(
                title: 'theme',
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
                onTap: () => Get.dialog(
                  buildChangeModeDialog(),
                ),
                leading: Icon(
                  settingController.isDarkMode
                      ? Icons.nights_stay
                      : Icons.light_mode_rounded,
                  color: isDark
                      ? ColorConstants.kYellowColor
                      : ColorConstants.kRedColor,
                ),
                subtitle: settingController.isDarkMode ? 'dark' : 'light',
              );
            }),
            SettingListTile(
              title: 'notification',
              trailing: buildNotificationSwitchButton(),
              onTap: () {},
              leading: Icon(
                Icons.notifications_active_rounded,
                color: isDark
                    ? ColorConstants.kYellowColor
                    : ColorConstants.kRedColor,
              ),
              subtitle: settingController.isNotificationOn ? 'on' : 'off',
            ),
            SettingListTile(
              title: 'export data',
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
              onTap: () {},
              leading: Icon(
                Icons.download_rounded,
                color: isDark
                    ? ColorConstants.kYellowColor
                    : ColorConstants.kRedColor,
              ),
              subtitle: 'export data to excel',
            ),
            SettingListTile(
              title: 'deleteacc',
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
              onTap: () {},
              leading: const Icon(
                Icons.delete_forever_rounded,
                color: ColorConstants.kRedColor,
              ),
              subtitle: 'deletealldata',
            ),
          ],
        ),
      );
    });
  }

  Container buildExportBodyButton(
      {required String title, required IconData icon}) {
    return Container(
      alignment: Alignment.center,
      width: Get.width,
      margin: const EdgeInsets.only(bottom: AppSizes.m10),
      padding: const EdgeInsets.symmetric(
        vertical: AppSizes.p8,
        horizontal: AppSizes.p16,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: settingController.isDarkMode
              ? ColorConstants.kBGColor
              : Colors.black,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title.tr,
          ),
          Icon(
            icon,
          )
        ],
      ),
    );
  }

  GetBuilder<SettingController> buildNotificationSwitchButton() {
    return GetBuilder<SettingController>(
      builder: (context) {
        return Switch(
          activeColor: ColorConstants.kWhiteColor,
          activeTrackColor: ColorConstants.kGreenColor,
          value: settingController.isNotificationOn,
          onChanged: (value) {
            settingController.toggleNotification();
          },
        );
      },
    );
  }

  CustomDialog buildChangeLanguageDialog() {
    return CustomDialog(
      title: 'choose language',
      children: Column(
        children: [
          LanguageListTile(
            title: 'khmer',
            leading: Flag(Flags.cambodia),
            onTap: settingController.changeToKhmer,
            trailing: const SizedBox(),
          ),
          LanguageListTile(
            title: 'english',
            trailing: const SizedBox(),
            onTap: settingController.changeToEnglish,
            leading: Flag(
              Flags.united_kingdom,
            ),
          ),
        ],
      ),
    );
  }

  CustomDialog buildChangeModeDialog() {
    return CustomDialog(
      title: 'change theme',
      children: Column(
        children: [
          LanguageListTile(
            title: 'dark',
            leading: const Icon(Icons.dark_mode_rounded),
            onTap: () {
              settingController.isDarkMode ? null : settingController.toDark();
            },
            trailing: const SizedBox(),
          ),
          LanguageListTile(
            title: 'light',
            onTap: () {
              settingController.isDarkMode ? settingController.tolight() : null;
            },
            leading: const Icon(Icons.light_mode_rounded),
            trailing: const SizedBox(),
          ),
        ],
      ),
    );
  }
}
