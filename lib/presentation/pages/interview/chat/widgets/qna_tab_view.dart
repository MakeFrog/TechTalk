import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/interview_qnas_of_room_provider.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/selected_chat_room_provider.dart';
import 'package:techtalk/presentation/pages/interview/chat/widgets/qna_expansion_tile.dart';
import 'package:techtalk/presentation/widgets/common/box/empty_box.dart';
import 'package:techtalk/presentation/widgets/common/box/skeleton_box.dart';

class QnATabView extends HookConsumerWidget {
  const QnATabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();
    final room = ref.watch(selectedInterviewRoomProvider).requireValue;
    final completedQnAsAsync =
        ref.watch(interviewQnAsOfRoomProvider(room)).whenData(
              (value) => [
                ...value.where(
                  (e) => e.hasUserResponded && e.response!.state.isCompleted,
                ),
              ],
            );

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          /// Q@A LENGTH INDICATOR
          Padding(
            padding: const EdgeInsets.only(right: 16, top: 16, bottom: 4),
            child: completedQnAsAsync.when(
              data: (qnaList) {
                return Text(
                  '${qnaList.length}개의 문답',
                  style: AppTextStyle.alert2.copyWith(
                    color: AppColor.of.gray3,
                  ),
                );
              },
              error: (_, __) => const EmptyBox(),
              loading: () => const SkeletonBox(
                height: 13,
                width: 32,
                padding: EdgeInsets.symmetric(
                  vertical: 2,
                ),
              ),
            ),
          ),

          /// Q@A LIST
          completedQnAsAsync.when(
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
                  if (qnaList[index].hasUserResponded) {
                    return QnAExpansionTile(qnaList[index]);
                  } else {
                    return const EmptyBox();
                  }
                },
              );
            },
            error: (_, __) => const Center(
              child: Text(
                'error',
              ),
            ),
            loading: () => const CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}
