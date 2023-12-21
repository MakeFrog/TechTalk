import 'package:techtalk/app/di/locator.dart';
import 'package:techtalk/features/wrong_answer_note/data/remote/wrong_answer_note_remote_data_source.dart';
import 'package:techtalk/features/wrong_answer_note/repositories/wrong_answer_note_repository.dart';
import 'package:techtalk/features/wrong_answer_note/usecases/get_wrong_answer_note_questions_use_case.dart';
import 'package:techtalk/features/wrong_answer_note/usecases/get_wrong_answer_qnas_use_case.dart';

export 'data/models/wrong_answer_qna_model.dart';
export 'data/remote/wrong_answer_note_remote_data_source.dart';
export 'entities/wrong_answer_qna_entity.dart';
export 'repositories/wrong_answer_note_repository.dart';
export 'usecases/get_wrong_answer_note_questions_use_case.dart';

final wrongAnswerNoteRemoteDataSource =
    locator<WrongAnswerNoteRemoteDataSource>();
final wrongAnswerNoteRepository = locator<WrongAnswerNoteRepository>();
final getReviewNoteQuestionListUseCase = locator<GetWrongAnswerQnAUseCase>();
final getWrongAnswerNoteQuestionsUseCase =
    locator<GetWrongAnswerNoteQuestionsUseCase>();
