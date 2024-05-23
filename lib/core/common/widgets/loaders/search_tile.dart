import 'package:flutter/material.dart';
import 'package:tiktok_tdd/core/common/widgets/effects/shimmer_effect.dart';
import 'package:tiktok_tdd/core/utils/constants/sizes.dart';

class SearchTileLoader extends StatelessWidget {
  const SearchTileLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      leading: TShimmerEffect(
        radius: TSizes.borderRadiusXl,
        height: 60,
        width: 60,
      ),
      title: Padding(
        padding: EdgeInsets.only(bottom: TSizes.sm),
        child: TShimmerEffect(
          height: 45,
          width: 250,
          radius: TSizes.sm,
        ),
      ),
    );
  }
}
