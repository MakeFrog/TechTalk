import 'dart:math';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/core/constants/interview_type.enum.dart';
import 'package:techtalk/core/helper/list_extension.dart';
import 'package:techtalk/core/utils/base/base_use_case.dart';
import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/topic/entities/qna_entity.dart';
import 'package:techtalk/features/topic/repositories/topic_repository.dart';

///
/// 랜덤 Qna 목록을 호출하는 UseCase
/// [InterviewType] 타입에 따라 각기 다른 방식으로 랜덤한 qna 추출 및 리턴
///
class GetRandomQnasUseCase
    extends BaseUseCase<ChatRoomEntity, Result<List<ChatQnaEntity>>> {
  GetRandomQnasUseCase(this._chatRepository, this._topicRepository);

  final ChatRepository _chatRepository;
  final TopicRepository _topicRepository;

  @override
  FutureOr<Result<List<ChatQnaEntity>>> call(ChatRoomEntity room) async {
    try {
      final returnedQnas = switch (room.type) {
        /// 주제별 면접
        InterviewType.singleTopic => () async {
            final qna = await _chatRepository
                .getChatQnAs(room)
                .then((value) => value.getOrThrow());

            qna.extractFromFirstAndShuffle(
                room.progressInfo.totalQuestionCount);

            return qna;
          },

        /// 실전 면접
        InterviewType.practical => () async {
            final List<QnaEntity> resolvedQnas = [];
            final topicCount = room.topics.length;
            final qnaCount = room.progressInfo.totalQuestionCount;
            final qnaCountPerTopic = qnaCount ~/ topicCount;

            int remainingQnaCount = qnaCount;

            for (final topic in room.topics) {
              final topicQnas =
                  await _topicRepository.getTopicQnas(topic.id).then(
                        (value) => value.getOrThrow(),
                      );

              topicQnas.extractFromFirstAndShuffle(
                  min(qnaCountPerTopic, remainingQnaCount));
              resolvedQnas.addAll(topicQnas);

              remainingQnaCount -= qnaCountPerTopic;
            }

            resolvedQnas.shuffle();

            final chatQns =
                resolvedQnas.map(ChatQnaEntity.fromQnaEntity).toList();

            return chatQns;
          }
      };

      print('우지랑이');
      return Result.success(await returnedQnas());
    } on Exception catch (e) {
      print('뭐가 문제 : ${e}');
      return Result.failure(e);
    }
  }
}
