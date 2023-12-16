import 'package:techtalk/app/di/locator.dart';
import 'package:techtalk/features/wrong_answer_note/repositories/wrong_answer_note_repository.dart';
import 'package:techtalk/features/wrong_answer_note/usecases/get_wrong_answer_qnas_use_case.dart';

export 'repositories/wrong_answer_note_repository.dart';

final wrongAnswerNoteRepository = locator<WrongAnswerNoteRepository>();
final getReviewNoteQuestionListUseCase =
    locator<GetReviewNoteQuestionListUseCase>();
