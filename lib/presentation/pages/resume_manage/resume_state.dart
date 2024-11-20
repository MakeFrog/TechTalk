import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/features/user/user.dart';
import 'package:techtalk/presentation/pages/interview/topic_select/providers/interview_topic_select_scroll_controller_provider.dart';
import 'package:techtalk/presentation/providers/user/user_info_provider.dart';
import 'package:techtalk/presentation/providers/user/user_topics_provider.dart';

mixin class ResumeState {
  ///
  /// 등록된 스킬과 연관된 면접 주제+ 면접 기록이 있는 면접 주제
  ///
  List<TopicEntity> targetedTopics(WidgetRef ref) =>
      ref.watch(userTopicsProvider);

  ///
  /// 유저 엔티티 정보
  ///
  AsyncValue<UserEntity?> userAsync(WidgetRef ref) =>
      ref.watch(userInfoProvider);

  ///
  /// 유저 엔티티 정보
  ///
  UserEntity? user(WidgetRef ref) => ref.watch(userInfoProvider).requireValue;

  ///
  /// 스크롤 컨트롤러
  ///
  ScrollController scrollController(WidgetRef ref) =>
      ref.watch(interviewTopicSelectScrollControllerProvider);
}
