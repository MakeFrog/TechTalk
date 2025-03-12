import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smooth_sheets/smooth_sheets.dart';
import 'package:techtalk/core/modules/regex/app_validator.dart';
import 'package:techtalk/features/tech_set/repositories/entities/skillt_entity.dart';
import 'package:techtalk/presentation/pages/my_info/skill_setting/providers/searched_skills_provider.dart';
import 'package:techtalk/presentation/widgets/base/controller_holder.dart';
import 'package:techtalk/presentation/widgets/section/search_tech_set/constant/tech_set_type.enum.dart';
import 'package:techtalk/presentation/widgets/section/search_tech_set/provider/search_skill_provider.dart';
import 'package:techtalk/presentation/widgets/section/tech_selection_bottom_sheet/provider/tech_selection_bottom_sheet_resource_provider.dart';

mixin class SearchTechSetState {
  ///
  /// 입력폼 컨트롤러
  ///
  TextEditingController textEditingController(WidgetRef ref) =>
      ref.watch(searchSkillProvider.select((c) => c.controller));

  ///
  /// Tab 컨트롤러
  ///
  TabController tabController(BuildContext context) =>
      context.getController<TabController>();

  ///
  /// 검색된 스킬 리스트
  ///
  List<SkillEntity> searchedSkills(WidgetRef ref) =>
      ref.watch(searchedSkillsProvider);
}
