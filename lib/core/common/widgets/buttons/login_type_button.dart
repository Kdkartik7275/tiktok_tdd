// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:tiktok_tdd/core/common/widgets/containers/rounded_container.dart';
import 'package:tiktok_tdd/core/utils/constants/colors.dart';
import 'package:tiktok_tdd/core/utils/constants/sizes.dart';

class LoginTypeButton extends StatelessWidget {
  final String text;
  final Widget leading;
  final Function()? ontap;

  const LoginTypeButton({
    Key? key,
    required this.text,
    required this.leading,
    this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: TRoundedContainer(
        height: 50,
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
        radius: TSizes.xs,
        backgroundColor: TColors.background,
        borderColor: TColors.white,
        showBorder: true,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(TSizes.sm),
              child: leading,
            ),
            Expanded(
                child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
            ))
          ],
        ),
      ),
    );
  }
}
