import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:techtalk/features/blog/data_sources/remote/models/blog_main_model.dart';
import 'package:techtalk/features/blog/repository/entity/blog_shell_entity.dart';
import 'package:techtalk/features/tech_set/repositories/entities/tech_set_entity.dart';
import 'package:techtalk/features/tech_set/tech_set.dart';
import 'package:techtalk/presentation/pages/blog/blog_main/provider/blog_category_provider.dart';
import 'package:techtalk/presentation/pages/blog/blog_main/provider/blog_content_pagination_provider.dart';
import 'package:techtalk/presentation/widgets/common/constant/content_filter_category.dart';

mixin class BlogMainState {
  ///
  /// 페이지네이션 컨트롤러
  ///
  PagingController<DocumentSnapshot<BlogMainModel>?, BlogShellEntity>
      pagingController(WidgetRef ref) {
    final selectedCategory =
        ref.watch(blogContentCategoryProvider).selectedCategory;

    final pagingController =
        ref.watch(blogContentPaginationProvider(category: selectedCategory));
    return pagingController;
  }

  ///
  /// 페이지 컨트롤러
  ///
  PageController pageController(WidgetRef ref) =>
      ref.watch(blogContentCategoryProvider.select((p) => p.pageController));

  ///
  /// 콘텐츠 카테고리 리스트
  ///
  List<ContentFilterCategory> totalCategories(WidgetRef ref) =>
      ref.watch(blogContentCategoryProvider.select((p) => p.totalCategories));

  ///
  /// 블로그 업로드 노티 버튼 노출 여부
  ///
  bool showTryUploadIndicator(WidgetRef ref) {
    return false; // 추후 구현
  }

  ///
  /// 기술 스택 목록
  ///
  List<TechSetEntity> getSkills() {
    return techSetRepository.getSkills();
  }

  ///
  /// 선택된 카테고리
  ///
  ContentFilterCategory selectedCategory(WidgetRef ref) =>
      ref.watch(blogContentCategoryProvider.select((p) => p.selectedCategory));
}
