import 'package:flutter/material.dart';
import 'package:tiktok_tdd/core/common/widgets/effects/shimmer_effect.dart';
import 'package:tiktok_tdd/core/common/widgets/loaders/loading_user_card.dart';
import 'package:tiktok_tdd/core/utils/constants/sizes.dart';

class ReelLoader extends StatelessWidget {
  const ReelLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          child: const TShimmerEffect(
            height: double.infinity,
            width: double.infinity,
          ),
        ),
        const Positioned(
          bottom: 0,
          child: LoadingUserCard(),
        ),
        Positioned(
          bottom: MediaQuery.of(context).size.height / 8,
          right: 15,
          child: TShimmerEffect(
            radius: TSizes.sm,
            height: MediaQuery.of(context).size.height / 2,
            width: 50,
          ),
        ),
        const Positioned(
          bottom: 10,
          right: 15,
          child: TShimmerEffect(
            radius: TSizes.borderRadiusXl,
            height: 60,
            width: 60,
          ),
        ),
      ],
    );
  }
}
