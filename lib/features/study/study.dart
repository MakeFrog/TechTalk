import 'package:techtalk/app/di/locator.dart';
import 'package:techtalk/features/study/data/local/study_local_data_source.dart';
import 'package:techtalk/features/study/data/remote/study_remote_data_source.dart';
import 'package:techtalk/features/study/repositories/study_repository.dart';
import 'package:techtalk/features/study/usecases/get_study_question_list_use_case.dart';

export 'data/local/study_local_data_source.dart';
export 'data/remote/study_remote_data_source.dart';
export 'entities/study_question_entity.dart';
export 'entities/study_question_list_entity.dart';
export 'repositories/study_repository.dart';
export 'usecases/get_study_question_list_use_case.dart';

final studyRemoteDataSource = locator<StudyRemoteDataSource>();
final studyLocalDataSource = locator<StudyLocalDataSource>();
final studyRepository = locator<StudyRepository>();
final getStudyQuestionListUseCase = locator<GetStudyQuestionListUseCase>();
