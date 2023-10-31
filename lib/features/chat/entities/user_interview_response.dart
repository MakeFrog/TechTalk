import 'package:techtalk/features/chat/chat.dart';

class UserInterviewResponse {
  final String text;
  final AnswerState state;

  UserInterviewResponse(this.text, {required this.state});
}
