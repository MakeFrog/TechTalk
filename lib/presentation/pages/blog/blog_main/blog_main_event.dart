import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/presentation/pages/blog/blog_main/provider/blog_category_provider.dart';

mixin class BlogMainEvent {
  void onSkillSelected(WidgetRef ref, String skillId) {
    // ref.read(blogContentCategoryProvider.notifier).toggleCategorySelection();
  }

  void onBlogUploadBtnTapped(BuildContext context) {
    // 추후 구현
  }

  Future<void> fetchNextPage() async {
    // 추후 구현
  }
}
