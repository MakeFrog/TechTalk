import 'package:techtalk/features/chat/repositories/enums/qna_type.enum.dart';
import 'package:uuid/uuid.dart';

abstract class BaseQnaEntity {
  /// 고유 id 값
  final String id;

  /// 질문
  final String question;

  /// 문답 유형
  final QnaType type;

  BaseQnaEntity({
    String? id,
    required this.question,
    required this.type,
  }) : id = id ?? const Uuid().v1();
}
