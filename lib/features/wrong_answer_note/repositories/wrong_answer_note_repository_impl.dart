import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/features/wrong_answer_note/wrong_answer_note.dart';

class WrongAnswerNoteRepositoryImpl implements WrongAnswerNoteRepository {
  const WrongAnswerNoteRepositoryImpl({
    required this.remoteDataSource,
  });

  final WrongAnswerNoteRemoteDataSource remoteDataSource;

  @override
  Future<Result<List<WrongAnswerNoteEntity>>> getWrongAnswerNotes(
    String topicId,
  ) async {
    final noteModel = await remoteDataSource.getWrongAnswerNotes(topicId);

    final notes = <WrongAnswerNoteEntity>[];
    await Future.forEach(noteModel, (element) async {
      final question = await topicRepository.getTopicQna(
        topicId,
        element.id,
      );

      final note = WrongAnswerNoteEntity(
        id: element.id,
        question: question.getOrThrow(),
        answers: element.answers
            .map(
              (e) => WrongAnswerNoteAnswerEntity(
                chatRoomId: e.chatRoomId,
                messsageId: e.messageId,
                answer: 'answer $e',
              ),
            )
            .toList(),
      );

      notes.add(note);
    });

    return Result.success(notes);
  }
}
