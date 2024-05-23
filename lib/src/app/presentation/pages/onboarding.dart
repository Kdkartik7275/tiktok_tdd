import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_tdd/core/common/widgets/buttons/login_type_button.dart';
import 'package:tiktok_tdd/core/utils/constants/colors.dart';
import 'package:tiktok_tdd/core/utils/constants/images.dart';
import 'package:tiktok_tdd/core/utils/constants/sizes.dart';
import 'package:tiktok_tdd/core/utils/constants/texts.dart';
import 'package:tiktok_tdd/core/utils/navigator/navigators.dart';
import 'package:tiktok_tdd/src/authentication/presentation/pages/login.dart';
import 'package:tiktok_tdd/src/authentication/presentation/pages/signup.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: TSizes.xs),
        child: Column(
          children: [
            const Spacer(),
            Text(
              TTexts.onboardTitle,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            Text(TTexts.onboardSubtitle,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .apply(color: TColors.textGrey)),
            const SizedBox(height: TSizes.spaceBtwSections),
            LoginTypeButton(
                ontap: () =>
                    TNavigators.navigatePush(context, const LoginScreen()),
                leading: const Icon(
                  Icons.person,
                  color: TColors.white,
                ),
                text: "Use phone/ email/ username"),
            const LoginTypeButton(
                leading: Image(image: AssetImage(TImages.fb)),
                text: "Log in with Facebook"),
            const LoginTypeButton(
                leading: Image(image: AssetImage(TImages.google)),
                text: "Log in with Google"),
            const Spacer(),
            RichText(
              text: TextSpan(
                text: 'Don\'t have an account? ',
                style: Theme.of(context).textTheme.titleMedium,
                children: [
                  TextSpan(
                    text: 'Sign up',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .apply(color: TColors.lightRed),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => TNavigators.navigatePush(
                          context, const SignUpScreen()),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
