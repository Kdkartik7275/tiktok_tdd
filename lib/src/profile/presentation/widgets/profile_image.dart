// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:tiktok_tdd/core/common/widgets/containers/circular_container.dart';
import 'package:tiktok_tdd/core/common/widgets/effects/shimmer_effect.dart';
import 'package:tiktok_tdd/core/utils/constants/sizes.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    Key? key,
    required this.profileURL,
    this.height = 100,
    this.width = 100,
  }) : super(key: key);

  final String profileURL;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return TCircularContainer(
      height: height,
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(TSizes.borderRadiusXl),
        child: CachedNetworkImage(
          imageUrl: profileURL,
          fit: BoxFit.cover,
          height: height,
          width: width,
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              TShimmerEffect(
            height: height,
            width: width,
            radius: 20,
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
