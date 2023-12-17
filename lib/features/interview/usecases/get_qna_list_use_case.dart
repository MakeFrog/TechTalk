import 'package:techtalk/core/utils/base/base_use_case.dart';
import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/interview/entities/qna_entity.dart';
import 'package:techtalk/features/interview/interview.dart';

final class GetQnaListUseCase
    extends BaseUseCase<String, Result<List<QnaEntity>>> {
  GetQnaListUseCase(this._interviewRepository);

  final InterviewRepository _interviewRepository;

  @override
  Future<Result<List<QnaEntity>>> call(String request) =>
      _interviewRepository.getQnaList(request);
}
