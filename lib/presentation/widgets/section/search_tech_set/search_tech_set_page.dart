import 'package:bounce_tapper/bounce_tapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/app/style/app_text_style.dart';
import 'package:techtalk/core/services/app_size.dart';
import 'package:techtalk/presentation/widgets/base/index.dart';
import 'package:techtalk/presentation/widgets/common/animated/animated_size_and_fade.dart';
import 'package:techtalk/presentation/widgets/common/app_bar/back_button_app_bar.dart';
import 'package:techtalk/presentation/widgets/common/bottom_sheet/bottom_sheet_intent.dart';
import 'package:techtalk/presentation/widgets/common/input/techtalk_text_field.dart';
import 'package:techtalk/presentation/widgets/common/tab_bar/techtalk_tab_bar.dart';
import 'package:techtalk/presentation/widgets/section/search_tech_set/search_tech_set_state.dart';
import 'package:techtalk/presentation/widgets/section/search_tech_set/search_tehc_set_event.dart';
import 'package:techtalk/presentation/widgets/section/searched_skill_list_view.dart';
import 'package:techtalk/presentation/widgets/section/tech_selection_bottom_sheet/tech_set_selection_bottom_sheet.dart';

import 'constant/tech_set_type.enum.dart';

part 'widgets/job_group_selection_list_view.p.dart';
part 'widgets/leading_view.p.dart';
part 'widgets/scaffold.p.dart';
part 'widgets/search_bar.p.dart';
part 'widgets/searched_skill_list_view.p.dart';
part 'widgets/tab_bar.p.dart';

class SearchTechSetPage extends BasePage with SearchTechSetState {
  const SearchTechSetPage({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return _Scaffold(
      leadingView: _LeadingView(),
      searchBar: _SearchBar(),
      techSetSelectionBottomSheet: SizedBox(),
      // techSetSelectionBottomSheet: _TechSetSelectionBottomSheet(),
      tabBar: _TabBar(),
      searchSkillListView: _SearchedSkillListView(),
      jobGroupSelectionListView: _JobGroupSelectionListView(),
      bottomFixedBtn: SizedBox(),
    );
  }

  @override
  Widget? buildFloatingActionButton(WidgetRef ref) {
    // TODO: implement buildFloatingActionButton
    return super.buildFloatingActionButton(ref);
  }

  // @override
  // PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) {
  //   return const BackButtonAppBar();
  // }

  @override
  bool get wrapWithSafeArea => false;
}
