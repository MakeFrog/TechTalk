import 'package:techtalk/features/chat/repositories/enums/qna_type.enum.dart';

abstract class BaseQnaEntity {
  /// 고유 id 값
  final String id;

  /// 질문
  final String question;

  /// 문답 유형
  final QnaType type;

  const BaseQnaEntity({
    required this.id,
    required this.question,
    required this.type,
  });
}
