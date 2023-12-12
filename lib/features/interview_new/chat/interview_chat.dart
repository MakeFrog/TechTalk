import 'package:techtalk/app/di/locator.dart';
import 'package:techtalk/features/interview/data/local/interview_local_data_source.dart';
import 'package:techtalk/features/interview/data/remote/interview_remote_data_source.dart';
import 'package:techtalk/features/interview/repositories/interview_repository.dart';

export 'entities/chat_type.enum.dart';
export 'entities/interview_progress_info_entity.dart';
export 'entities/interview_room_entity.dart';
export 'entities/interviewer_avatar.dart';
export 'entities/messages/feedback_message_entity.dart';
export 'entities/messages/guide_message_entity.dart';
export 'entities/messages/interview_message_entity.dart';
export 'entities/messages/question_message_entity.dart';
export 'entities/messages/sent_message_entity.dart';
export 'entities/states/answer_state.enum.dart';
export 'entities/states/feedback_progress_state.enum.dart';
export 'entities/states/interview_progress_state.enum.dart';
export 'entities/states/interview_result_state.enum.dart';

final interviewRemoteDataSource = locator<InterviewRemoteDataSource>();
final interviewLocalDataSource = locator<InterviewLocalDataSource>();
final interviewRepository = locator<InterviewRepository>();
