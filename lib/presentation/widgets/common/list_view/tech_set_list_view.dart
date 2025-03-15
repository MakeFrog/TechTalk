import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:techtalk/features/tech_set/repositories/entities/tech_set_entity.dart';
import 'package:techtalk/presentation/widgets/common/animated/animated_size_and_fade.dart';
import 'package:techtalk/presentation/widgets/common/chip/closable_skill_filled_chip.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

class TechSetListView extends StatelessWidget {
  const TechSetListView({
    super.key,
    required this.techSets,
    required this.onItemTapped,
    this.height = 56,
    this.alignment = Alignment.centerLeft,
    this.scrollController,
  });

  final double height;
  final Alignment alignment;
  final List<TechSetEntity> techSets;
  final ScrollController? scrollController;
  final void Function(TechSetEntity item) onItemTapped;

  @override
  Widget build(BuildContext context) {
    return AnimatedSizeAndFade(
      sizeDuration: const Duration(milliseconds: 320),
      fadeDuration: const Duration(milliseconds: 326),
      child: techSets.isNotEmpty
          ? SizedBox(
              height: height,
              child: Center(
                child: Align(
                  alignment: alignment,
                  child: ListView.separated(
                    controller: scrollController,
                    padding: const EdgeInsets.only(left: 16, right: 24),
                    itemCount: techSets.length,
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (_, __) => const Gap(8),
                    itemBuilder: (context, index) {
                      final techSet = techSets[index];
                      return Center(
                        child: techSet.fold(skill: (skill) {
                          return ClosableFilledChip(
                            logoPath: skill.imagePath,
                            name: skill.name,
                            onTap: () {
                              onItemTapped(techSet);
                            },
                          );
                        }, jobGroup: (jobGroup) {
                          return Center(
                            child: ClosableFilledChip(
                              name: jobGroup.name,
                              onTap: () {
                                onItemTapped(techSet);
                              },
                            ),
                          );
                        }),
                      );
                    },
                  ),
                ),
              ),
            )
          : const EmptyBox(),
    );
  }
}
