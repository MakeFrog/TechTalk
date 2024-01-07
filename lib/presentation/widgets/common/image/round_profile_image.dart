import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:techtalk/core/helper/cached_image_size_extension.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

class RoundProfileImg extends StatelessWidget {
  const RoundProfileImg({super.key, required this.size, this.imgUrl});

  final double size;
  final String? imgUrl;

  factory RoundProfileImg.createSkeleton({required double size}) =>
      RoundProfileImg(size: size, imgUrl: 'skeleton');

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        if (imgUrl == 'skeleton') {
          return SkeletonBox(
            height: size,
            width: size,
            borderRadius: size / 2,
          );
        } else {
          return ClipRRect(
            borderRadius: BorderRadius.circular(size / 2),
            child: imgUrl != null
                ? CachedNetworkImage(
                    height: size,
                    width: size,
                    memCacheHeight: size.cacheSize(context),
                    imageUrl: imgUrl!,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const SkeletonBox(),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey.withOpacity(0.1),
                      child: const Center(
                        child: Icon(Icons.error),
                      ),
                    ),
                  )
                : Image.asset(
                    'assets/images/blank_profile.png',
                    height: size,
                    width: size,
                    fit: BoxFit.cover,
                  ),
          );
        }
      },
    );
  }
}
