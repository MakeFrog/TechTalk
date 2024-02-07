import 'dart:async';

import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/topic/topic.dart';

final class SearchTopicsUseCase {
  SearchTopicsUseCase();

  FutureOr<Result<List<TopicEntity>>> call(String keyword) async {
    if (keyword.isEmpty) {
      return Result.success([]);
    }

    final topics = await getTopicsUseCase(includeUnavailable: true);

    return Result.success([
      ...topics.getOrThrow().where(
            (e) => e.text.toLowerCase().startsWith(
                  keyword.toLowerCase(),
                ),
          ),
    ]);
  }
}
