import 'package:expense_tracker/constants/app_size.dart';
import 'package:expense_tracker/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/style_constant.dart';
import '../controller/home_controller.dart';
import 'home_header.dart';

GetBuilder<HomeController> buildHomeBody() {
  return GetBuilder<HomeController>(
    init: HomeController(),
    builder: (controller) {
      return PageView.builder(
        itemCount: controller.pageItem.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              buildHomeHeader(index: index),
              ListView.builder(
                padding: const EdgeInsets.only(
                  top: AppSizes.p10,
                  right: AppSizes.p16,
                  left: AppSizes.p16,
                  bottom: 70,
                ),
                shrinkWrap: true,
                itemCount: 2,
                itemBuilder: (context, index) {
                  return SectionHeader(
                    controller: controller,
                    index: index,
                  );
                },
              ),
            ],
          );
        },
      );
    },
  );
}

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.controller,
    required this.index,
  });

  final HomeController controller;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: AppSizes.p5,
                horizontal: AppSizes.p10,
              ),
              decoration: BoxDecoration(
                color: ColorConstants.kYellowColor,
                borderRadius: BorderRadius.circular(AppSizes.m5),
              ),
              child: Text(
                'today'.tr,
                style: TextStyleConstant.kTitleSmallTextStyle,
              ),
            ),
            Center(
              child: Text(
                '\$${controller.pageItem[index]}',
                style: const TextStyle(
                  color: ColorConstants.kBlueColor,
                  fontSize: AppSizes.s20,
                ),
              ),
            ),
          ],
        ),
        ListView.builder(
          padding: const EdgeInsets.symmetric(
              vertical: AppSizes.p5, horizontal: AppSizes.p5),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 3,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: AppSizes.p5),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.p16,
                vertical: AppSizes.p8,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSizes.m5),
                color: ColorConstants.kGreyColor.withOpacity(.4),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        const Icon(Icons.abc),
                        Text('${controller.pageItem[controller.currentIndex]}')
                      ],
                    ),
                  ),
                  Text(
                    '${controller.pageItem[index]} USD',
                    style: TextStyleConstant.kTitleSmallTextStyle,
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
