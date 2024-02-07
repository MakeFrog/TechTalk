import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/features/tech_set/repositories/entities/skill_entity.dart';
import 'package:techtalk/presentation/pages/sign_up/events/sign_up_event.dart';

class SearchedSkillListView extends ConsumerWidget with SignUpEvent {
  const SearchedSkillListView(
      {required this.items,
      required this.searchedTerm,
      required this.onItemTapped,
      super.key});

  final List<SkillEntity> items;
  final String searchedTerm;
  final Function(SkillEntity item) onItemTapped;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onVerticalDragDown: (_) {
        onSearchedListViewDrag(context);
      },
      child: ListView.builder(
        itemCount: items.length,
        itemExtent: 52,
        itemBuilder: (context, index) {
          final skill = items[index];

          final separatedString = getProcessString(
            ref,
            skill: skill.name,
            searchedTerm: searchedTerm,
          );

          return ListTile(
            minVerticalPadding: 0,
            title: Align(
              alignment: Alignment.centerLeft,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: separatedString.$1,
                    ),
                    TextSpan(
                      text: separatedString.$2,
                      style: TextStyle(
                        color: AppColor.of.gray4,
                      ),
                    ),
                  ],
                ),
                style: AppTextStyle.body2,
              ),
            ),
            onTap: () {
              onItemTapped(skill);
            },
          );
        },
      ),
    );
  }

  ///
  /// 검색된 문자열과 스킬 문자열을 비교하여
  /// 포함 여부를 판단하여 리턴하는 메소드
  ///
  (String containedText, String uncontainedText) getProcessString(WidgetRef ref,
      {required String skill, required String searchedTerm}) {
    String lowerInput = skill.toLowerCase().trim();
    String lowerKeyword = searchedTerm.toLowerCase().trim();

    int index = searchedTerm.isNotEmpty ? lowerInput.indexOf(lowerKeyword) : 1;

    String prefix = skill.substring(0, index + searchedTerm.length);
    String suffix = skill.substring(index + searchedTerm.length);

    return (prefix, suffix);
  }
}
