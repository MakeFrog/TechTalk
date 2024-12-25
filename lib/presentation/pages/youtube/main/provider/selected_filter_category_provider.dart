import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/constants/content_filter_category_type.enum.dart';
import 'package:techtalk/presentation/pages/youtube/main/constant/yotubue_content_filter.dart';
import 'package:techtalk/presentation/providers/user/user_info_provider.dart';

///
/// 컨텐츠 카테고리를 관리하는 provider
///
class YoutubeContentCategoryProvider extends ChangeNotifier {
  ///
  /// 선택된 필터 카테고리
  ///
  final YoutubeContentFiler selectedCategory;

  final List<YoutubeContentFiler> totalCategory;

  YoutubeContentCategoryProvider({
    required this.selectedCategory,
    required this.totalCategory,
  });
}

final youtubeContentCategoryProvider =
    ChangeNotifierProvider<YoutubeContentCategoryProvider>(
  (ref) {
    final userInfo = ref.read(userInfoProvider).requireValue!;

    final skills = userInfo.skills;
    final jobGroups = userInfo.jobGroups;

    final List<YoutubeContentFiler> combined = [
      /// TODO : XIMYA
      /// LOCALIZATION 필요
      const YoutubeContentFiler(
        id: 'all',
        name: '전체',
        type: ContentFilterCategoryType.all,
      )
    ];

    for (var skill in skills) {
      combined.add(YoutubeContentFiler.fromSkill(skill));
    }

    for (var job in jobGroups) {
      combined.add(YoutubeContentFiler.fromJob(job));
    }

    return YoutubeContentCategoryProvider(
      selectedCategory: combined.first, // '전체' 카테고리는 디폴트 값
      totalCategory: combined,
    );
  },
);
