import 'dart:math';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/core/constants/interview_type.dart';
import 'package:techtalk/core/helper/string_extension.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/topic/topic.dart';

part 'chat_qnas_provider.g.dart';

@riverpod
class ChatQnAs extends _$ChatQnAs {
  Future<List<ChatQnaEntity>> _getRandomQnas() async {
    final List<TopicQnaEntity> resolvedQnas = [];
    switch (room.type) {
      case InterviewType.topic:
        final qnas = await getTopicQnasUseCase(room.topics.first.id).then(
          (value) => value.getOrThrow(),
        )
          ..shuffle();
        resolvedQnas.addAll(
          qnas.sublist(0, room.progressInfo.totalQuestionCount),
        );
      case InterviewType.practical:
        final topicCount = room.topics.length;
        final qnaCount = room.progressInfo.totalQuestionCount;
        final qnaCountPerTopic = qnaCount ~/ topicCount;

        int remainingQnaCount = qnaCount;
        for (final topic in room.topics) {
          final qnas = await getTopicQnasUseCase(topic.id).then(
            (value) => value.getOrThrow(),
          )
            ..shuffle();
          resolvedQnas.addAll(
            qnas.sublist(0, min(qnaCountPerTopic, remainingQnaCount)),
          );
          remainingQnaCount -= qnaCountPerTopic;
        }
        resolvedQnas.shuffle();
    }

    return resolvedQnas
        .map(
          (e) => ChatQnaEntity(
            id: e.id,
            question: e,
          ),
        )
        .toList();
  }

  @override
  FutureOr<List<ChatQnaEntity>> build(ChatRoomEntity room) async {
    final qnas = await getChatQnasUseCase(room);
    return qnas.fold(
      onSuccess: (value) async {
        if (value.isEmpty) {
          return _getRandomQnas();
        } else {
          return value;
        }
      },
      onFailure: (e) async {
        return _getRandomQnas();
      },
    );
  }

  Future<void> updateState(AnswerChatMessageEntity message) async {
    final qnas = state.requireValue;
    final targetQnaIndex = qnas.indexWhere(
      (element) => element.id == message.qnaId,
    );
    final resolvedQna = qnas[targetQnaIndex].copyWith(
      answer: message,
    );

    await update((previous) {
      return [...previous]..[targetQnaIndex] = resolvedQna;
    });
  }

  QuestionChatMessageEntity createQuestionChat({
    bool isStream = true,
  }) {
    final qna = state.requireValue.firstWhere((qna) => !qna.hasUserResponded);

    if (isStream) {
      return QuestionChatMessageEntity(
        qnaId: qna.id,
        message: qna.question.question.convertToStreamText,
      );
    } else {
      return QuestionChatMessageEntity.createStatic(
        qnaId: qna.id,
        message: qna.question.question,
        timestamp: DateTime.now(),
      );
    }
  }
}
