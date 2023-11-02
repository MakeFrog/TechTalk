import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/chat/entities/interview_qna_entity.dart';
import 'package:techtalk/presentation/pages/chat/providers/total_qna_list_provider.dart';

part 'completed_qna_list_provider.g.dart';

///
/// [totalQnaListProvider]의 QnA 리스트 중
/// 유저의 응답의 정답 확인 완료된 QnA리스트만 필터링된 값을 반환하는 provider
///

@riverpod
AsyncValue<List<InterviewQnAEntity>> completedQnAList(
  CompletedQnAListRef ref,
) {
  final qnaList = ref.watch(totalQnaListProvider);

  return qnaList.map(
    data: (list) {
      final filteredValue = list.value.where((e) {
        if (e.hasUserResponded) {
          // 유저 응답 여부
          if (e.response!.state.isCompleted) {
            // 정답 확인 완료 여부
            return true;
          }
        }
        return false;
      }).toList();
      return AsyncData(filteredValue);
    },
    error: (e) => AsyncError(e, e.stackTrace),
    loading: (_) => const AsyncLoading(),
  );
}
