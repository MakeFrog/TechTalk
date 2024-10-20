import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:techtalk/core/services/app_size.dart';

class SkillSelectionScaffold extends StatelessWidget {
  const SkillSelectionScaffold(
      {super.key,
      required this.introTextView,
      required this.selectedSkillSlider,
      required this.searchBar,
      required this.searchedSkillListView,
      required this.bottomFixedBtn});

  final Widget introTextView;
  final Widget selectedSkillSlider;
  final Widget searchBar;
  final Widget searchedSkillListView;
  final Widget bottomFixedBtn;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        introTextView,
        selectedSkillSlider,
        const Gap(16),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              children: [
                searchBar,
                Expanded(
                  child: searchedSkillListView,
                ),
              ],
            ),
          ),
        ),
        Container(
          color: Colors.white,
          margin: EdgeInsets.only(bottom: AppSize.bottomInset == 0 ? 16 : 0),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: bottomFixedBtn,
        )
      ],
    );
  }
}
