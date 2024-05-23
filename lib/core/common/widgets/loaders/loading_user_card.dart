import 'package:flutter/material.dart';
import 'package:tiktok_tdd/core/common/widgets/effects/shimmer_effect.dart';
import 'package:tiktok_tdd/core/utils/constants/sizes.dart';

class LoadingUserCard extends StatelessWidget {
  const LoadingUserCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width / 1.3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                TShimmerEffect(
                  height: 40,
                  radius: TSizes.sm,
                  width: MediaQuery.of(context).size.width / 2.0,
                ),
                const SizedBox(width: TSizes.sm),
                TShimmerEffect(
                  height: 40,
                  radius: TSizes.sm,
                  width: MediaQuery.of(context).size.width / 5,
                ),
              ],
            ),
            const SizedBox(height: TSizes.sm),
            TShimmerEffect(
              height: 30,
              radius: TSizes.sm,
              width: MediaQuery.of(context).size.width / 1.3,
            ),
            const SizedBox(height: TSizes.sm),
            TShimmerEffect(
              height: 30,
              radius: TSizes.sm,
              width: MediaQuery.of(context).size.width / 1.3,
            ),
          ],
        ),
      ),
    );
  }
}
