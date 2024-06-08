import 'package:expense_tracker/constants/app_size.dart';
import 'package:expense_tracker/constants/color_constant.dart';
import 'package:expense_tracker/views/setting/controller/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import '../../utils/custom_dialog.dart';
import 'widgets/setting_listtile.dart';

class SettingView extends StatelessWidget {
  SettingView({super.key});
  final SettingController settingController = Get.put(SettingController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('application setting'.tr),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSizes.p16),
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: ColorConstants.kWhiteColor,
              ),
            ),
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(AppSizes.p5),
              physics: const NeverScrollableScrollPhysics(),
              children: [
                SettingListTile(
                  title: 'theme',
                  trailing: const SizedBox(),
                  onTap: () {},
                  leading: const Icon(Icons.nights_stay),
                ),
                SettingListTile(
                  title: 'language',
                  trailing: Flag(
                    !settingController.isEnglish
                        ? Flags.united_kingdom
                        : Flags.cambodia,
                  ),
                  onTap: () => Get.dialog(
                    CustomDialog(
                      title: 'choose language',
                      children: Column(
                        children: [
                          SettingListTile(
                            title: 'khmer',
                            leading: Flag(Flags.cambodia),
                            onTap: settingController.changeToKhmerLang,
                            trailing: const SizedBox(),
                          ),
                          SettingListTile(
                            title: 'english',
                            trailing: const SizedBox(),
                            onTap: settingController.changeToEngLang,
                            leading: Flag(
                              Flags.united_kingdom,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  leading: const Icon(
                    Icons.g_translate_rounded,
                    color: ColorConstants.kWhiteColor,
                  ),
                ),
                SettingListTile(
                  title: 'notification',
                  trailing: GetBuilder<SettingController>(builder: (context) {
                    return Switch(
                      inactiveTrackColor: ColorConstants.kGreyColor,
                      activeColor: ColorConstants.kWhiteColor,
                      activeTrackColor: ColorConstants.kGreenColor,
                      value: settingController.isNotificationOn,
                      onChanged: (value) {
                        settingController.toggleNotification();
                      },
                    );
                  }),
                  onTap: () {},
                  leading: const Icon(Icons.notifications_active_rounded),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
