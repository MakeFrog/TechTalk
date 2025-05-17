import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/presentation/pages/blog/blog_main/provider/blog_category_provider.dart';
import 'package:techtalk/presentation/widgets/common/constant/content_filter_category.dart';

mixin class BlogMainEvent {
  ///
  /// 컨텐츠 카테고리 chip이 클릭 되었을 때
  ///
  void onCategoryChipTapped(WidgetRef ref,
      {required ContentFilterCategory targetCategory, required int index}) {
    ref
        .read(blogContentCategoryProvider.notifier)
        .toggleCategorySelection(targetCategory);

    final pageController =
        ref.read(blogContentCategoryProvider.select((p) => p.pageController));
    pageController.animateToPage(
      index,
      duration: const Duration(microseconds: 1),
      curve: Curves.bounceIn,
    );
  }

  void onBlogUploadBtnTapped(BuildContext context) {
    // 추후 구현
  }

  Future<void> fetchNextPage() async {
    // 추후 구현
  }
}
