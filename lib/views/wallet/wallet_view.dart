import 'package:expense_tracker/utils/custom_appbar.dart';
import 'package:expense_tracker/views/wallet/wallet_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WalletView extends GetView<WalletController> {
  const WalletView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        title: 'wallet',
        leading: const BackButton(),
        actions: const SizedBox(),
      ),
    );
  }
}
