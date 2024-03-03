import 'package:techtalk/features/chat/chat.dart';

class ChatHistoryCollectionEntity {
  final List<BaseChatEntity> chatHistories;
  final List<String> progressQnaIds;

  ChatHistoryCollectionEntity(
      {required this.chatHistories, required this.progressQnaIds});
}
