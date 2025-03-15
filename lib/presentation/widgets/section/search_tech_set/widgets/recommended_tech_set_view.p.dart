part of '../search_tech_set_page.dart';

class _RecommendedTechSetsView extends ConsumerWidget
    with SearchTechSetState, SearchTechSetEvent {
  const _RecommendedTechSetsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTechSetListView(
            ref,
            title: '추천 직군',
            techSets: userJobGroupCollection(ref),
          ),
          const Gap(16),
          _buildTechSetListView(
            ref,
            title: '추천 스킬',
            techSets: userSkillCollection(ref),
          ),
        ],
      ),
    );
  }

  Column _buildTechSetListView(
    WidgetRef ref, {
    required String title,
    required List<TechSetEntity> techSets,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyle.body3.copyWith(color: AppColor.of.gray4),
        ),
        const Gap(12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ...techSets.map((e) {
              return TechSetFilledChip(
                item: e,
                onTap: (techSet) {
                  addTechToSelection(ref,
                      techSet: e,
                      scrollController:
                          ref.context.getController<ScrollController>());
                },
              );
            }),
          ],
        ),
        const Gap(12),
      ],
    );
  }
}
