import 'package:flutter/material.dart';
import 'package:tiktok_tdd/core/utils/constants/colors.dart';

class TSnackBar {
  static void showSuccessSnackBar(
      {required BuildContext context, required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).primaryColor,
        duration: const Duration(seconds: 2),
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: TColors.white, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  static void showErrorSnackBar(
      {required BuildContext context, required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: TColors.error,
        duration: const Duration(seconds: 2),
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: TColors.white, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
