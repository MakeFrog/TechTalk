enum FirestoreCollection {
  users('users'),
  usersWrongAnswers('wrongAnswers'),
  usersWrongAnswersQna('qna'),
  interview('interview'),
  interviewQuestions('questions'),
  chats('chats'),
  chatsQna('qna'),
  messages('messages');

  final String name;

  const FirestoreCollection(this.name);
}
