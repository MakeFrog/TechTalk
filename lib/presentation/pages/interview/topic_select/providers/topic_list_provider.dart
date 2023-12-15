import 'dart:developer';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/core/services/toast_service.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

part 'topic_list_provider.g.dart';

@riverpod
FutureOr<List<Topic>> topicList(TopicListRef ref) async {
  await Future.delayed(1.seconds);

  final response = await getTopicsUseCase();

  return response.fold(
    onSuccess: (topics) {
      return topics;
    },
    onFailure: (e) {
      ToastService.show(CustomToast(message: e.toString()));
      log(e.toString());
      throw e;
    },
  );
}
