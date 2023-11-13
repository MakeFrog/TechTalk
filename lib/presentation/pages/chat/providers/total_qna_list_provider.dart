import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/core/helper/list_extension.dart';
import 'package:techtalk/core/services/toast_service.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

part 'total_qna_list_provider.g.dart';

@Riverpod(keepAlive: true)
class TotalQnaList extends _$TotalQnaList {
  @override
  AsyncValue<List<InterviewQnAEntity>> build() {
    return const AsyncLoading();
  }

  ///
  /// Qna 리스트 초기화 (처음 채팅방에 진입할 경우)
  ///
  void initializeQnaList() {
    state = const AsyncData([]);
  }

  ///
  /// 채팅 기록을 기반으로 Qna 리스트 초기화 (진행중인 채팅방에 진입할 경우)
  ///
  void updateQnaListByChat(List<ChatEntity> chats) {
    final response = retrieveQnaListFromChatListUseCase(chats);
    return response.fold(
      onSuccess: (totalQnaList) {
        state = AsyncData(totalQnaList);
      },
      onFailure: (e) {
        ToastService.show(
          toast: NormalToast(message: '$e'),
        );
        throw e;
      },
    );
  }

  ///
  /// 유저 응답 데이터 갱신
  ///
  Future<void> updateUserQnaResponse(UserInterviewResponse userResponse) async {
    final previous = state.requireValue;

    final targetIndex =
        previous.firstIndexWhereOrNull((qna) => qna.hasUserNotRespondedYet);

    if (targetIndex != null) {
      previous[targetIndex].response = userResponse;
      state = AsyncData(previous);
    } else {
      throw UnimplementedError('qna 항목의 구성에 오류가 있습니다');
    }
  }

  ///
  /// Qna List 데이터 추가 (질문 + 모범답변)
  ///
  Future<void> addQnaList(InterviewQuestionEntity question) async {
    final response = await getQuestionIdealAnswersUseCase(question);

    await response.fold(
      onSuccess: (idealAnswers) async {
        final newQna = InterviewQnAEntity.fromInitialQuestionModel(
          id: question.id,
          question: question.content,
          idealAnswer: idealAnswers,
        );
        final previous = state.requireValue;
        state = AsyncData([...previous, newQna]);
      },
      onFailure: (e) {
        log(e.toString());
      },
    );
  }

  ///
  /// NOTE : state 초기화 되기전에 해당 메소드가 사용되면 안됨.
  /// 현재 Qna 리스트 반환
  ///
  List<InterviewQnAEntity> returnQnaList() {
    return state.value!;
  }
}
