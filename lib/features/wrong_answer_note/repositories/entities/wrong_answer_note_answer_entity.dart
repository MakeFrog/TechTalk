class WrongAnswerNoteAnswerEntity {
  final String chatRoomId;
  final String messsageId;
  final String answer;

//<editor-fold desc="Data Methods">
  const WrongAnswerNoteAnswerEntity({
    required this.chatRoomId,
    required this.messsageId,
    required this.answer,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WrongAnswerNoteAnswerEntity &&
          runtimeType == other.runtimeType &&
          chatRoomId == other.chatRoomId &&
          messsageId == other.messsageId &&
          answer == other.answer);

  @override
  int get hashCode =>
      chatRoomId.hashCode ^ messsageId.hashCode ^ answer.hashCode;

  @override
  String toString() {
    return 'WrongAnswerNoteAnswerEntity{' +
        ' chatRoomId: $chatRoomId,' +
        ' messsageId: $messsageId,' +
        ' answer: $answer,' +
        '}';
  }

  WrongAnswerNoteAnswerEntity copyWith({
    String? chatRoomId,
    String? messsageId,
    String? answer,
  }) {
    return WrongAnswerNoteAnswerEntity(
      chatRoomId: chatRoomId ?? this.chatRoomId,
      messsageId: messsageId ?? this.messsageId,
      answer: answer ?? this.answer,
    );
  }

//</editor-fold>
}
