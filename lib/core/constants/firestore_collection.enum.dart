enum FirestoreCollection {
  users('users'),
  usersWrongAnswers('wrongAnswers'),
  usersWrongAnswersQna('qna'),
  interview('interview'),
  interviewQuestions('questions'),
  chats('chats'),
  messages('messages');

  final String name;

  const FirestoreCollection(this.name);
}
