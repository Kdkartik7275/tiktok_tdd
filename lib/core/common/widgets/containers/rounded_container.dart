// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:tiktok_tdd/core/utils/constants/colors.dart';
import 'package:tiktok_tdd/core/utils/constants/sizes.dart';

class TRoundedContainer extends StatelessWidget {
  const TRoundedContainer({
    Key? key,
    this.height,
    this.width,
    this.radius = TSizes.borderRadiusLg,
    this.child,
    this.margin,
    this.padding,
    this.backgroundColor = TColors.white,
    this.showBorder = false,
    this.borderColor = TColors.white,
    this.gradient,
  }) : super(key: key);

  final double? height;
  final double? width;
  final double radius;
  final Widget? child;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final bool showBorder;
  final Color borderColor;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: backgroundColor,
          gradient: gradient,
          border:
              showBorder ? Border.all(color: borderColor, width: 0.3) : null),
      child: child,
    );
  }
}
