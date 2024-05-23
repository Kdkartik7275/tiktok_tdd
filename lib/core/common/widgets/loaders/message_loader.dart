import 'package:flutter/material.dart';
import 'package:tiktok_tdd/core/common/widgets/effects/shimmer_effect.dart';
import 'package:tiktok_tdd/core/utils/constants/sizes.dart';

class MessageLoader extends StatelessWidget {
  const MessageLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: 15,
        itemBuilder: (context, index) {
          return Row(
            mainAxisAlignment: index % 2 == 0
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: const [
              TShimmerEffect(
                height: 30,
                width: 200,
                radius: TSizes.sm,
              ),
            ],
          );
        },
        separatorBuilder: (_, index) {
          return const SizedBox(
            height: 15,
          );
        },
      ),
    );
  }
}
