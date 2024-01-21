import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/constants/interview_type.enum.dart';
import 'package:techtalk/features/topic/entities/topic_entity.dart';
import 'package:techtalk/presentation/pages/interview/chat_list/providers/chat_list_route_arg.dart';

mixin class ChatListState {
  ///
  /// 선택된 인터뷰 타입
  ///
  InterviewType selectedInterviewType(WidgetRef ref) =>
      ref.watch(chatListRouteArgProvider).interviewType;

  ///
  /// 선택된 면접 주제
  ///
  TopicEntity? selectedTopic(WidgetRef ref) =>
      ref.watch(chatListRouteArgProvider).topic;
}
