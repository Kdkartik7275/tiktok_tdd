// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:tiktok_tdd/core/common/widgets/containers/rounded_container.dart';
import 'package:tiktok_tdd/core/utils/constants/colors.dart';
import 'package:tiktok_tdd/core/utils/constants/sizes.dart';

class TElevatedButton extends StatelessWidget {
  final Widget text;
  final Function()? onPressed;
  final double? height;
  final double? width;
  final double radius;

  const TElevatedButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.height,
    this.width = double.infinity,
    this.radius = TSizes.borderRadiusXl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      height: height,
      width: width,
      radius: radius,
      backgroundColor: TColors.lightRed,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent),
        onPressed: onPressed,
        child: text,
      ),
    );
  }
}
