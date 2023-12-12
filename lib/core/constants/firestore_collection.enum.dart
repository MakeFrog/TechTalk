enum FirestoreCollection {
  users('users'),
  usersWrongAnswerNote('wrong-answer_note'),
  usersWrongAnswerNoteQnas('qnas'),
  interview('interview'),
  interviewQuestions('questions'),
  skills(''),
  chats('chats'),
  messages('messages');

  final String name;

  const FirestoreCollection(this.name);
}
