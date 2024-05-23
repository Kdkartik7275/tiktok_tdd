import 'package:flutter/material.dart';
import 'package:tiktok_tdd/core/common/widgets/appbar/appbar.dart';
import 'package:tiktok_tdd/core/common/widgets/effects/shimmer_effect.dart';
import 'package:tiktok_tdd/core/utils/constants/sizes.dart';

class ProfileLoader extends StatelessWidget {
  const ProfileLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: TAppBar(),
      body: Column(
        children: [
          TShimmerEffect(
            height: 80,
            width: 80,
            radius: TSizes.borderRadiusXl,
          ),
          const SizedBox(height: TSizes.spaceBtwItems),
          TShimmerEffect(height: 30, width: 100, radius: TSizes.sm),
          const SizedBox(height: TSizes.spaceBtwItems),
          TShimmerEffect(height: 50, width: double.infinity, radius: TSizes.sm),
          const SizedBox(height: TSizes.spaceBtwItems),
          TShimmerEffect(height: 50, width: 150, radius: TSizes.sm),
          const SizedBox(height: TSizes.spaceBtwItems),
        ],
      ),
    );
  }
}
