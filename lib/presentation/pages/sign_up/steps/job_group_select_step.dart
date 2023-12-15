import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/features/job/job.dart';
import 'package:techtalk/presentation/pages/sign_up/sign_up_event.dart';
import 'package:techtalk/presentation/pages/sign_up/widgets/select_result_chip_list_view.dart';
import 'package:techtalk/presentation/pages/sign_up/widgets/sign_up_step_intro_message.dart';

class JobGroupSelectStep extends HookConsumerWidget with SignUpEvent {
  const JobGroupSelectStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();
    final selectedJobGroups = useState<List<JobGroupEntity>>([]);

    return Column(
      children: [
        Expanded(
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 4),
                  child: SignUpStepIntroMessage(
                    title: '관심있는 직군을\n알려주세요.',
                    subTitle: '1개 이상 선택해 주세요.',
                  ),
                ),
              ),
              SliverPersistentHeader(
                floating: true,
                pinned: true,
                delegate: _SelectedJobGroupListViewDelegate(
                  jobGroups: selectedJobGroups.value,
                  onTapItem: (index) => selectedJobGroups.value =
                      selectedJobGroups.value..removeAt(index),
                ),
              ),
              HookBuilder(
                builder: (context) {
                  final getJobGroups = useMemoized(getJobGroupsUseCase);
                  final getJobGroupsAsync = useFuture(getJobGroups);

                  if (getJobGroupsAsync.connectionState ==
                      ConnectionState.waiting) {
                    return const SliverFillRemaining(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (getJobGroupsAsync.hasError) {
                    return SliverFillRemaining(
                      child: Center(
                        child: Text('${getJobGroupsAsync.error}'),
                      ),
                    );
                  }

                  final jobGroups =
                      getJobGroupsAsync.requireData.getOrThrow().groups;

                  return SliverList.builder(
                    itemCount: jobGroups.length,
                    itemBuilder: (context, index) {
                      final group = jobGroups[index];
                      final isSelected =
                          selectedJobGroups.value.contains(group);

                      return ListTile(
                        selected: isSelected,
                        selectedColor: AppColor.of.black,
                        selectedTileColor: AppColor.of.background1,
                        minVerticalPadding: 0,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 16),
                        title: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            group.name,
                            style: AppTextStyle.body2,
                          ),
                        ),
                        trailing: isSelected
                            ? FaIcon(
                                FontAwesomeIcons.solidCircleCheck,
                                color: AppColor.of.brand2,
                                size: 20,
                              )
                            : null,
                        onTap: () {
                          if (selectedJobGroups.value.contains(group)) {
                            selectedJobGroups.value =
                                selectedJobGroups.value.toList()..remove(group);
                          } else {
                            selectedJobGroups.value =
                                selectedJobGroups.value.toList()..add(group);
                          }
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: FilledButton(
            onPressed: selectedJobGroups.value.isNotEmpty
                ? () => onTapJobGroupStepNext(
                      ref,
                      jobGroups: selectedJobGroups.value,
                    )
                : null,
            child: const Center(
              child: Text('다음'),
            ),
          ),
        )
      ],
    );
  }
}

class _SelectedJobGroupListViewDelegate extends SliverPersistentHeaderDelegate {
  const _SelectedJobGroupListViewDelegate({
    required this.jobGroups,
    required this.onTapItem,
  });

  final List<JobGroupEntity> jobGroups;
  final void Function(int index) onTapItem;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      alignment: Alignment.center,
      height: 68,
      color: Colors.white,
      child: SelectResultChipListView(
        itemList: jobGroups.map((e) => e.name).toList(),
        onTapItem: onTapItem,
      ),
    );
  }

  @override
  double get maxExtent => 68;

  @override
  double get minExtent => 68;

  @override
  bool shouldRebuild(covariant _SelectedJobGroupListViewDelegate oldDelegate) {
    return oldDelegate.jobGroups != jobGroups;
  }
}
