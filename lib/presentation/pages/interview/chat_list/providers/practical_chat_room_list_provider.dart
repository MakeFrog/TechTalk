import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/core/constants/interview_type.enum.dart';
import 'package:techtalk/core/services/snack_bar_servbice.dart';
import 'package:techtalk/features/chat/chat.dart';

part 'practical_chat_room_list_provider.g.dart';

@Riverpod(keepAlive: true)
class PracticalChatRoomList extends _$PracticalChatRoomList {
  @override
  FutureOr<List<ChatRoomEntity>> build() async {
    final response = await getChatRoomsUseCase.call(InterviewType.practical);
    return response.fold(
      onSuccess: (chatRooms) {
        return chatRooms;
      },
      onFailure: (e) {
        SnackBarService.showSnackBar('면접 채팅 목록을 가져오지 못하였습니다');
        log('error : $e');
        throw e;
      },
    );
  }
}
