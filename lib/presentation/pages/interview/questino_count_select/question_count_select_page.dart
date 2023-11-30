import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:techtalk/core/services/size_service.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/presentation/pages/interview/questino_count_select/provider/selected_question_count_provider.dart';
import 'package:techtalk/presentation/pages/interview/questino_count_select/question_count_select_event.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';
import 'package:techtalk/presentation/widgets/common/app_bar/back_button_app_bar.dart';
import 'package:techtalk/presentation/widgets/common/box/empty_box.dart';

class QuestionCountSelectPage extends BasePage {
  const QuestionCountSelectPage({Key? key}) : super(key: key);

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    List<int> options = List.generate(18, (index) => index + 3); // 3 ~ 20

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const HeightBox(20),
          _buildLeadingMessage(),
          Expanded(
            child: Center(
              child: SizedBox(
                height: AppSize.to.screenHeight * 0.6,
                child: CupertinoPicker.builder(
                  scrollController: FixedExtentScrollController(
                    initialItem: options
                        .indexOf(ref.watch(selectedQuestionCountProvider)),
                  ),
                  useMagnifier: true,
                  magnification: 1.22,
                  squeeze: 1.2,
                  itemExtent: 35,
                  childCount: options.length,
                  onSelectedItemChanged: (value) {
                    final selectedCount = options[value];
                    ref
                        .read(selectedQuestionCountProvider.notifier)
                        .onCountPickerChanged(selectedCount);
                  },
                  itemBuilder: (context, index) {
                    return Text(
                      options[index].toString(),
                      style: const TextStyle(
                        fontSize: 24,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          const _StartInterviewBtn(),
        ],
      ),
    );
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) =>
      const BackButtonAppBar();

  Widget _buildLeadingMessage() {
    return Text(
      '면접 질문 개수를\n선택해주세요',
      style: AppTextStyle.headline1,
    );
  }
}

class _StartInterviewBtn extends ConsumerWidget
    with QuestionCountSelectedEvent {
  const _StartInterviewBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FilledButton(
      onPressed: () {
        routeToChatPage(ref);
      },
      child: const Center(
        child: Text('시작하기'),
      ),
    );
  }
}
