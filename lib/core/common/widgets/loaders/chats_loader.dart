import 'package:flutter/material.dart';
import 'package:tiktok_tdd/core/common/widgets/effects/shimmer_effect.dart';
import 'package:tiktok_tdd/core/utils/constants/sizes.dart';

class ChatsLoader extends StatelessWidget {
  const ChatsLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return const ListTile(
            leading: TShimmerEffect(
              radius: TSizes.borderRadiusXl,
              height: 60,
              width: 60,
            ),
            title: Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: TShimmerEffect(
                height: 30,
                width: 250,
                radius: TSizes.sm,
              ),
            ),
            subtitle: TShimmerEffect(
              height: 30,
              width: 250,
              radius: TSizes.sm,
            ),
            trailing: TShimmerEffect(
              height: 30,
              width: 70,
              radius: TSizes.sm,
            ),
          );
        },
        separatorBuilder: (context, index) =>
            const SizedBox(height: TSizes.spaceBtwItems),
        itemCount: 10);
  }
}
