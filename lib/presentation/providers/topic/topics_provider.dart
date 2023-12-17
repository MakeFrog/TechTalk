import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/topic/topic.dart';

part 'topics_provider.g.dart';

@Riverpod(keepAlive: true)
Future<List<Topic>> topics(TopicsRef ref) async {
  return (await getTopicsUseCase()).fold(
    onSuccess: (value) => value,
    onFailure: (e) {
      log('$e');

      throw e;
    },
  );
}
