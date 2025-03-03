import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/localization/locale_keys.g.dart';
import 'package:techtalk/core/constants/content_filter_category_type.enum.dart';
import 'package:techtalk/features/tech_set/tech_set.dart';
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
    final userSkills = userInfo.skills;
    final userJobGroups = userInfo.jobGroups;
    final totalSkills = techSetRepository.getSkills();
    final totalJobGroups = techSetRepository.getJobs();

    // 1. 전체 스킬, 직군 중 콘텐츠 개수가 가장 많은 6개씩 추출
    final topSkillCategories = totalSkills
        .map((skill) => YoutubeContentCategory.fromSkill(skill))
        .toList()
      ..sort((a, b) => b.contentCount.compareTo(a.contentCount));

    final topJobGroupCategories = totalJobGroups
        .map((job) => YoutubeContentCategory.fromJob(job))
        .toList()
      ..sort((a, b) => b.contentCount.compareTo(a.contentCount));

    final topSkillCategoriesLimited = topSkillCategories.take(6).toList();
    final topJobGroupCategoriesLimited = topJobGroupCategories.take(6).toList();

    // 2. 유저의 관심 스킬 및 직군 추가 (중복 제거)
    final userSkillCategories = userSkills
        .map((skill) => YoutubeContentCategory.fromSkill(skill))
        .toList();

    final userJobGroupCategories = userJobGroups
        .map((job) => YoutubeContentCategory.fromJob(job))
        .toList();

    final userOwnedCategories = [
      ...userSkillCategories,
      ...userJobGroupCategories,
    ].toSet().toList();

    // 3. 유저 관심 카테고리를 맨 앞에 정렬, 나머지는 셔플
    final allCategories = [
      ...userOwnedCategories, // 유저 관심 스킬 및 직군
      ...[...topSkillCategoriesLimited, ...topJobGroupCategoriesLimited]
          .where((category) => !userOwnedCategories.contains(category)) // 중복 제거
    ];

    allCategories.shuffle(); // 나머지 셔플

    final sortedCategories = [
      ...userOwnedCategories..shuffle(), // 유저 관심 카테고리 우선 배치
      ...allCategories
    ].toSet();

    // 4. '전체' 카테고리 추가
    final combined = [
      YoutubeContentCategory(
        id: 'all',
        name: tr(LocaleKeys.common_all),
        type: ContentFilterCategoryType.all,
        contentCount: 0,
      ),
      ...sortedCategories,
    ];

    return YoutubeContentCategoryProvider(
      selectedCategory: combined.first, // '전체' 카테고리는 디폴트 값
      totalCategories: combined,
    );
  },
);
