import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/core/services/snack_bar_service.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/chat/repositories/enums/interview_type.enum.dart';

part 'practical_chat_room_list_provider.g.dart';

@riverpod
class PracticalChatRoomList extends _$PracticalChatRoomList {
  @override
  FutureOr<List<ChatRoomEntity>> build() async {
    final response = await getChatRoomsUseCase.call(InterviewType.practical);
    return response.fold(
      onSuccess: (chatRooms) => chatRooms,
      onFailure: (e) {
        SnackBarService.showSnackBar('면접 채팅 목록을 가져오지 못하였습니다');
        log('error : $e');
        throw e;
      },
    );
  }
}
