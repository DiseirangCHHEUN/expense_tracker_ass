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
    return Scaffold(
      appBar: buildAppBar(
          title: 'setting',
          leading: const SizedBox(),
          actions: const SizedBox()),
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
            leading: const Icon(
              Icons.category_rounded,
              color: ColorConstants.kYellowColor,
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
            leading: const Icon(
              Icons.wallet,
              color: ColorConstants.kYellowColor,
            ),
            subtitle: 'usd',
          ),
          SettingListTile(
            title: 'language',
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
            onTap: () => Get.dialog(
              buildChangeLanguageDialog(),
            ),
            leading: const Icon(
              Icons.g_translate_rounded,
              color: ColorConstants.kYellowColor,
            ),
            subtitle: settingController.isEnglish ? 'khmer' : 'english',
          ),
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
                color: ColorConstants.kYellowColor,
              ),
              subtitle: settingController.isDarkMode ? 'dark' : 'light',
            );
          }),
          SettingListTile(
            title: 'notification',
            trailing: buildNotificationSwitchButton(),
            onTap: () {},
            leading: const Icon(
              Icons.notifications_active_rounded,
              color: ColorConstants.kYellowColor,
            ),
            subtitle: settingController.isNotificationOn ? 'on' : 'off',
          ),
          SettingListTile(
            title: 'export data',
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
            onTap: () {},
            leading: const Icon(
              Icons.download_rounded,
              color: ColorConstants.kYellowColor,
            ),
            subtitle: 'export data to excel',
          ),
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
            onTap: settingController.changeToKhmerLang,
            trailing: const SizedBox(),
          ),
          LanguageListTile(
            title: 'english',
            trailing: const SizedBox(),
            onTap: settingController.changeToEngLang,
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
