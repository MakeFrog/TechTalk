import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/constants/content_filter_category_type.enum.dart';
import 'package:techtalk/presentation/pages/youtube/main/constant/yotubue_content_category.dart';
import 'package:techtalk/presentation/providers/user/user_info_provider.dart';

///
/// 컨텐츠 카테고리를 관리하는 provider
///
class YoutubeContentCategoryProvider extends ChangeNotifier {
  ///
  /// 페이지 컨트롤러
  ///
  PageController pageController = PageController();

  ///
  /// 선택된 카테고리
  ///
  YoutubeContentCategory selectedCategory;

  ///
  /// 전체 카티고리 리스트
  ///
  final List<YoutubeContentCategory> totalCategories;

  ///
  /// 선택된 카테고리 토글
  ///
  void toggleCategorySelection(YoutubeContentCategory targetCategory) {
    selectedCategory = targetCategory;
    notifyListeners();
  }

  YoutubeContentCategoryProvider({
    required this.selectedCategory,
    required this.totalCategories,
  });
}

final youtubeContentCategoryProvider =
    ChangeNotifierProvider<YoutubeContentCategoryProvider>(
  (ref) {
    final userInfo = ref.read(userInfoProvider).requireValue!;

    final skills = userInfo.skills;
    final jobGroups = userInfo.jobGroups;

    final List<YoutubeContentCategory> combined = [
      /// TODO : XIMYA
      /// LOCALIZATION 필요
      const YoutubeContentCategory(
        id: 'all',
        name: '전체',
        type: ContentFilterCategoryType.all,
      )
    ];

    for (var skill in skills) {
      combined.add(YoutubeContentCategory.fromSkill(skill));
    }

    for (var job in jobGroups) {
      combined.add(YoutubeContentCategory.fromJob(job));
    }

    return YoutubeContentCategoryProvider(
      selectedCategory: combined.first, // '전체' 카테고리는 디폴트 값
      totalCategories: combined,
    );
  },
);
