import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_size.dart';
import '../../../constants/color_constant.dart';
import '../../../constants/style_constant.dart';
import '../controller/home_controller.dart';

GetBuilder<HomeController> buildHomeHeader({required int index}) {
  return GetBuilder<HomeController>(
    init: HomeController(),
    builder: (controller) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.p16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BackButton(
              onPressed: () => controller.goPreviouse(),
              color: controller.currentIndex == 0
                  ? ColorConstants.kGreyColor
                  : null,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.p10, vertical: AppSizes.p5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  width: 1,
                  color: ColorConstants.kYellowColor,
                ),
              ),
              child: GetBuilder<HomeController>(
                  init: HomeController(),
                  builder: (controller) {
                    return Text(
                      '${controller.pageItem[index]}/2024',
                      style: TextStyleConstant.kTitleSmallTextStyle,
                    );
                  }),
            ),
            IconButton(
              onPressed: () => controller.goNext(),
              icon: Icon(
                Icons.arrow_forward_rounded,
                color: controller.currentIndex == controller.pageItem.length - 1
                    ? ColorConstants.kGreyColor
                    : null,
              ),
            ),
          ],
        ),
      );
    },
  );
}
