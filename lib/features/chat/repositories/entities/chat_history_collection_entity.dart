import 'package:techtalk/features/chat/chat.dart';

class ChatHistoryCollectionEntity {
  final List<ChatMessageEntity> chatHistories;
  final List<String> progressQnaIds;

  ChatHistoryCollectionEntity(
      {required this.chatHistories, required this.progressQnaIds});
}
