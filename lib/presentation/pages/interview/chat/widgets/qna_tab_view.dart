import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/presentation/pages/interview/chat/chat_page.dart';
import 'package:techtalk/presentation/pages/interview/chat/chat_state.dart';
import 'package:techtalk/presentation/pages/interview/chat/widgets/qna_expansion_tile.dart';
import 'package:techtalk/presentation/widgets/common/box/empty_box.dart';
import 'package:techtalk/presentation/widgets/common/indicator/exception_indicator.dart';

class QnaTabView extends HookConsumerWidget with ChatState {
  const QnaTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();

    return ListView(
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      children: <Widget>[
        /// Q@A LENGTH INDICATOR
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 16, top: 16, bottom: 4),
          child: completedQnaListAsync(ref).when(
            data: (qnaList) {
              return Text(
                '${qnaList.length}개의 문답',
                style: AppTextStyle.alert2.copyWith(
                  color: AppColor.of.gray3,
                ),
              );
            },
            error: (_, __) => const EmptyBox(),
            loading: () => const EmptyBox(),
          ),
        ),

        /// Q@A LIST
        completedQnaListAsync(ref).when(
          data: (qnaList) {
            if (qnaList.isEmpty) {
              return Center(
                child: Text(
                  '완료된 문답 항목이 없습니다\n면접 질문에 답해보세요!',
                  textAlign: TextAlign.center,
                  style: AppTextStyle.title3.copyWith(
                    color: AppColor.of.gray3,
                  ),
                ),
              );
            }

            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: qnaList.length,
              separatorBuilder: (_, __) => Divider(
                thickness: 0.5,
                height: 0,
                color: AppColor.of.gray2,
              ),
              itemBuilder: (context, index) {
                return QnAExpansionTile(qnaList[index]);
              },
            );
          },
          error: (_, __) => SizedBox(
            height: ChatPage.tabViewHeight,
            child: const Center(
              child: ExceptionIndicator(
                  subTitle: '다시 시도해주세요', title: '문답 내역을 불러오지 못했어요.'),
            ),
          ),
          loading: () => SizedBox(
            height: ChatPage.tabViewHeight,
            child: const Center(child: CircularProgressIndicator()),
          ),
        ),
      ],
    );
  }
}
