import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/app/util/app_logger.dart';
import 'package:techtalk/features/chat/repositories/entities/selectable_qna_entity.dart';
import 'package:techtalk/features/tech_set/repositories/entities/tech_set_entity.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/features/user/user.dart';

part 'selectable_common_qnas_provider.g.dart';

@riverpod
class SelectableCommonQnas extends _$SelectableCommonQnas {
  // ignore: avoid_public_notifier_properties
  final List<String> bookMarkedQnaIds = [];

  @override
  FutureOr<List<SelectableQnaEntity<CommonQnaEntity>>> build(
      String topicId) async {
    final response = await userRepository.getBookMarkedQnas(techSetId: topicId);
    return response.fold(
      onSuccess: (qnas) {
        // 북마크된 ID 저장
        bookMarkedQnaIds.clear();
        qnas.forEach((qna) {
          if (qna.isSelected) {
            print('북마크됨 문제 : ${qna.qna.question}');
          }
        });

        bookMarkedQnaIds.addAll(
          qnas.where((qna) => qna.isSelected).map((qna) => qna.qna.id),
        );
        // isSelected를 false로 초기화
        final result = qnas
            .map((qna) => SelectableQnaEntity(
                  isSelected: false,
                  qna: qna.qna,
                ))
            .toList();

        logger.i('단골 질문 리스트 호출 : 북마크 개수 : ${bookMarkedQnaIds.length}');

        return result;
      },
      onFailure: (e) {
        logger.e(e);
        throw e;
      },
    );
  }

  ///
  /// 북마크 토글
  ///
  Future<void> toggleBookmark(
      SelectableQnaEntity<CommonQnaEntity> question) async {
    final response = await userRepository.togglCommonQnaBookMark(
        question: question.qna, setBookMark: !question.isSelected);
    response.fold(
      onSuccess: (_) {
        // 토글 성공 시 현재 상태 업데이트
        update((prev) {
          return prev.map((qna) {
            if (qna.qna.id == question.qna.id) {
              return SelectableQnaEntity(
                isSelected: !qna.isSelected,
                qna: qna.qna,
              );
            }
            return qna;
          }).toList();
        });
      },
      onFailure: (e) {
        logger.e(e);
        throw e;
      },
    );
  }

  ///
  /// 북마크된 모든 문답 선택
  ///
  void selectAllBookMarkedQnas() {
    update((prev) {
      return prev.map((qna) {
        if (bookMarkedQnaIds.contains(qna.qna.id)) {
          return SelectableQnaEntity(
            isSelected: true,
            qna: qna.qna,
          );
        }
        return qna;
      }).toList();
    });
  }
}
