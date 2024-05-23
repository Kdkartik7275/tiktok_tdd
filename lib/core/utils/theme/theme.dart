import 'package:flutter/material.dart';
import 'package:tiktok_tdd/core/utils/theme/widget_themes/appbar_theme.dart';
import 'package:tiktok_tdd/core/utils/theme/widget_themes/elevated_button_theme.dart';
import 'package:tiktok_tdd/core/utils/theme/widget_themes/text_field_theme.dart';
import 'package:tiktok_tdd/core/utils/theme/widget_themes/text_theme.dart';

import '../constants/colors.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    disabledColor: TColors.white,
    brightness: Brightness.light,
    primaryColor: TColors.lightRed,
    textTheme: TTextTheme.lightTextTheme,
    scaffoldBackgroundColor: TColors.background,
    inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme,
    appBarTheme: TAppBarTheme.lightAppBarTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
  );
}
