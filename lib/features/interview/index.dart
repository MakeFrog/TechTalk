import 'package:techtalk/app/di/index.dart';
import 'package:techtalk/features/interview/data_source/local/interview_local_data_source.dart';
import 'package:techtalk/features/interview/repository/interview_repository.dart';

final interviewLocalDataSource = locator<InterviewLocalDataSource>();
final interviewRepository = locator<InterviewRepository>();
