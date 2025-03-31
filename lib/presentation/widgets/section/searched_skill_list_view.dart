import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/app/style/app_text_style.dart';
import 'package:techtalk/features/tech_set/repositories/entities/tech_set_entity.dart';
import 'package:techtalk/presentation/widgets/common/image/rounded_skill_image.dart';

class SearchedSkillListView extends ConsumerWidget {
  const SearchedSkillListView(
      {required this.items,
      required this.searchedTerm,
      required this.onItemTapped,
      this.scrollPhysics,
      this.hideKeyboardOnScroll = true,
      this.shrinkWrap = false,
      this.padding,
      super.key});

  final List<SkillEntity> items;
  final ScrollPhysics? scrollPhysics;
  final String searchedTerm;
  final Function(SkillEntity item) onItemTapped;
  final bool shrinkWrap;
  final bool hideKeyboardOnScroll;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (hideKeyboardOnScroll) {
      return GestureDetector(
          onVerticalDragDown: (_) {
            if (FocusScope.of(context).hasFocus) {
              FocusScope.of(context).unfocus();
            }
          },
          child: _buildListView(ref));
    } else {
      return _buildListView(ref);
    }
  }

  Widget _buildListView(WidgetRef ref) {
    return ListView.builder(
      shrinkWrap: shrinkWrap,
      itemCount: items.length,
      physics: scrollPhysics,
      padding: padding ??
          const EdgeInsets.only(
            top: 8,
          ),
      itemBuilder: (context, index) {
        final skill = items[index];
        final separatedString = getProcessString(
          ref,
          skill: skill.name,
          searchedTerm: searchedTerm,
        );

        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            onItemTapped(skill);
          },
          child: SizedBox(
            height: 52,
            child: Row(
              children: [
                RoundedSkillImage(
                  disableRound: true,
                  imagePath: skill.imagePath,
                ),
                const Gap(6),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: separatedString.$1, // prefix
                          style: TextStyle(color: AppColor.of.gray4),
                        ),
                        TextSpan(
                          text: separatedString.$2, // match
                          style: TextStyle(color: AppColor.of.black),
                        ),
                        TextSpan(
                          text: separatedString.$3, // suffix
                          style: TextStyle(color: AppColor.of.gray4),
                        ),
                      ],
                    ),
                    style: AppTextStyle.body2,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  ///
  /// 검색된 문자열과 스킬 문자열을 비교하여
  /// 포함 여부를 판단하여 리턴하는 메소드
  ///
  (String prefix, String match, String suffix) getProcessString(
    WidgetRef ref, {
    required String skill,
    required String searchedTerm,
  }) {
    // 검색어와 스킬 문자열을 소문자로 변환하여 매칭 수행
    String lowerInput = skill.toLowerCase();
    String lowerKeyword = searchedTerm.toLowerCase().trim();

    // 검색어가 있는 경우 인덱스를 찾음
    int index = lowerInput.indexOf(lowerKeyword);

    // 검색어가 skill에 포함되지 않을 경우
    if (index == -1) {
      return (skill, '', '');
    }

    // 검색어 길이 계산 (trim 적용된 상태)
    int keywordLength = lowerKeyword.length;

    // prefix, match, suffix를 원래 문자열 기준으로 구분
    String prefix = skill.substring(0, index);
    String match = skill.substring(index, index + keywordLength);
    String suffix = skill.substring(index + keywordLength);

    return (prefix, match, suffix);
  }
}
