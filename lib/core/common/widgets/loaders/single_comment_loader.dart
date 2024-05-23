import 'package:flutter/material.dart';
import 'package:tiktok_tdd/core/common/widgets/effects/shimmer_effect.dart';
import 'package:tiktok_tdd/core/utils/constants/sizes.dart';

class SingleCommentLoader extends StatelessWidget {
  const SingleCommentLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      leading: TShimmerEffect(
        radius: TSizes.borderRadiusXl,
        height: 60,
        width: 60,
      ),
      title: Padding(
        padding: const EdgeInsets.only(bottom: TSizes.sm),
        child: TShimmerEffect(
          height: 30,
          width: double.infinity,
          radius: TSizes.sm,
        ),
      ),
      subtitle: TShimmerEffect(
        height: 30,
        width: double.infinity,
        radius: TSizes.sm,
      ),
      trailing: TShimmerEffect(
        radius: TSizes.borderRadiusXl,
        height: 30,
        width: 30,
      ),
    );
  }
}
