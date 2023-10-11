import 'package:flutter/material.dart';
import 'package:techtalk/presentation/pages/sign_up/widgets/select_result_chip_list_view.dart';
import 'package:techtalk/presentation/pages/sign_up/widgets/sign_up_step_introduction.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

class InterestJobSelectScreen extends StatelessWidget {
  const InterestJobSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: SignUpStepIntroduction(
            title: '관심있는 직군을\n알려주세요.',
            subTitle: '1개 이상 선택해 주세요.',
          ),
        ),
        // TODO : 선택한 직군 chips
        SelectResultChipListView(
          itemList: List.generate(10, (index) => 'test'),
          onTapXMark: (index) {},
        ),
        const HeightBox(16),
        // TODO : 직군 list
        Expanded(
          child: SizedBox(),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: FilledButton(
            onPressed: null,
            child: const Center(
              child: Text('다음'),
            ),
          ),
        ),
      ],
    );
  }
}
