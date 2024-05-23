import 'package:flutter/material.dart';

class TNavigators {
  static void navigatePushNamed(BuildContext context, String screen) {
    Navigator.of(context).pushNamed(
      screen,
    );
  }

  static void navigatePushNamedWithArguments(
      BuildContext context, String screen, Object? arguments) {
    Navigator.of(context).pushNamed(
      screen,
      arguments: arguments,
    );
  }

  static void navigatePush(BuildContext context, Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
  }

  static void navigatePop(BuildContext context) {
    Navigator.of(context).pop();
  }

  static void offALL(BuildContext context, Widget screen) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => screen), (route) => false);
  }

  static void ofAllNamed(
    BuildContext context,
    String screen,
  ) {
    Navigator.of(context).pushReplacementNamed(screen);
  }
}
