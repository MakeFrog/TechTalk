import 'package:flutter/material.dart';
import 'package:techtalk/presentation/widgets/common/box/skeleton_box.dart';

class ThumbnailImageView extends StatelessWidget {
  const ThumbnailImageView({super.key, this.url});

  final String? url;

  bool get isLoaded => url != null;

  factory ThumbnailImageView.createSkeleton() => const ThumbnailImageView();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        8,
      ),
      child: AspectRatio(
        aspectRatio: 263 / 148,
        child: isLoaded
            ? Image.network(
                url!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const ColoredBox(
                  color: Color(0xFFE2E2E2),
                  child: Center(
                    child: Text('영상을 가져오지 못했어요'),
                  ),
                ),
              )
            : const SkeletonBox(
                borderRadius: 0,
              ),
      ),
    );
  }
}
