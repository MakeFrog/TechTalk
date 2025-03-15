import 'package:bounce_tapper/bounce_tapper.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smooth_sheets/smooth_sheets.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/app/style/app_text_style.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/tech_set/repositories/entities/tech_set_entity.dart';
import 'package:techtalk/features/tech_set/repositories/enums/tech_set_type.enum.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';
import 'package:techtalk/presentation/widgets/common/list_view/tech_set_list_view.dart';
import 'package:techtalk/presentation/widgets/common/tile/job_group_list_tile.dart';
import 'package:techtalk/presentation/widgets/section/searched_skill_list_view.dart';
import 'package:techtalk/presentation/widgets/section/tech_selection_bottom_sheet/provider/tech_set_selection_bottom_sheet_route_arg_provider.dart';
import 'package:techtalk/presentation/widgets/section/tech_selection_bottom_sheet/tech_selection_bottom_sheet_state.dart';

import 'tech_selection_bottom_sheet_event.dart';

part 'widgets/header_selection_view.p.dart';
part 'widgets/job_group_page_view.p.dart';
part 'widgets/scaffold.p.dart';
part 'widgets/searched_skill_list_view.p.dart';
part 'widgets/selected_tech_set_list_view.p.dart';
part 'widgets/skill_page_view.p.dart';

class TechSetSelectionBottomSheet extends ConsumerWidget
    with TechSelectionBottomSheetState, TechSelectionBottomSheetEvent {
  const TechSetSelectionBottomSheet({super.key, required this.techSets});

  final List<TechSetEntity> techSets;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ProviderScope(
      overrides: [
        // ignore: scoped_providers_should_specify_dependencies
        techSetSelectionBottomSheetRouteArgProvider.overrideWithValue(
          techSets,
        ),
      ],
      child: Consumer(
        builder: (_, __, ___) {
          return const _Scaffold(
            headerSelectionView: _HeaderSelectionView(),
            selectedTechSetListView: _SelectedTechSetListView(),
            skillPageView: _SkillPageView(),
            jobGroupView: _JobGroupPageView(),
          );
        },
      ),
    );
  }
}
