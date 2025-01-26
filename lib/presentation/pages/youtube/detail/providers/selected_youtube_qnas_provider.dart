import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/core/helper/list_extension.dart';
import 'package:techtalk/features/chat/repositories/entities/youtube_qna_entity.dart';
import 'package:techtalk/presentation/pages/youtube/detail/providers/youtube_content_qna_provider.dart';

part 'selected_youtube_qnas_provider.g.dart';

@riverpod
class SelectedYoutubeQnas extends _$SelectedYoutubeQnas {
  @override
  List<YoutubeQnaEntity> build(
    String contentId, {
    required List<YoutubeQnaEntity>? passedQnas,
  }) {
    if (passedQnas?.isNotEmpty ?? false) {
      print('초기 아랑수');
      return passedQnas!;
    }
    final qnas = ref.read(youtubeContentQnaProvider(contentId)).value?.toList();
    return qnas ?? [];
  }

  void toggle(YoutubeQnaEntity qna) {
    final targetIndex = state.firstIndexWhereOrNull((e) => e.id == qna.id);
    print('아랑수요:  ${targetIndex}');
    if (targetIndex != null) {
      state = [...state]..removeAt(targetIndex);
    } else {
      state = [...state, qna];
    }
  }

  void activateAll() {
    final qnas = ref.read(youtubeContentQnaProvider(contentId)).value?.toList();

    if (qnas?.length == state.length) return;

    state = qnas ?? [];
  }
}
