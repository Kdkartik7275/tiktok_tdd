import 'package:flutter/material.dart';
import 'package:tiktok_tdd/core/utils/constants/sizes.dart';
import 'package:tiktok_tdd/core/utils/navigator/navigators.dart';

class TDialogs {
  static void showLoadingDialog(BuildContext context, String title) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            shape:
                const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title),
                const SizedBox(
                  width: TSizes.spaceBtwItems,
                ),
                const SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(),
                ),
              ],
            ),
          );
        });
  }

  static void stopDialog(BuildContext context) {
    TNavigators.navigatePop(context);
  }
}
