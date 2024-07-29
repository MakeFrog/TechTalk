import 'package:techtalk/app/localization/locale_keys.g.dart';

///
/// 유저의 면접 질문 답변 상태
///
enum AnswerState {
  initial('[i]', ''),
  loading('[l]', ''),
  correct('[c]', LocaleKeys.common_responseResult_correct),
  wrong('[w]', LocaleKeys.common_responseResult_incorrect),
  inappropriate('[i]', LocaleKeys.common_responseResult_incorrect);

  final String tag;
  final String str;

  const AnswerState(this.tag, this.str);

  bool get isCompleted => this == AnswerState.wrong || this == AnswerState.correct;
  bool get isInitial => this == AnswerState.initial;
  bool get isLoading => this == AnswerState.loading;
  bool get isCorrect => this == AnswerState.correct;
  bool get isWrong => this == AnswerState.wrong;
  bool get isInappropriate => this == AnswerState.inappropriate;

  static AnswerState getStateById(String id) {
    return values.firstWhere(
      (state) => state.tag == id,
      orElse: () => throw Exception('Unexpected Topic Id Value'),
    );
  }
}
