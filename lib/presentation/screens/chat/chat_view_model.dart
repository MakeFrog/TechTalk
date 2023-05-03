import 'package:flutter/material.dart';
import 'package:moon_dap/app/resources/uiConfig/size_config.dart';
import 'package:moon_dap/chatGptTest/useCase/check_answer_with_stream_response_use_case.dart';
import 'package:moon_dap/domain/enum/chat_message_type_enum.dart';
import 'package:moon_dap/domain/model/chat/chat.dart';
import 'package:moon_dap/presentation/base/base_view_model.dart';

class ChatViewModel extends BaseViewModel {
  ChatViewModel({required this.checkAnswerWithStreamResponse});

  /* Data Variables */
  List<Chat> chatList = Chat.generate();

  List<Chat> get chatListed => chatList;
  List<int> tempState = [0, 1];

  /* State Variables */
  int selectedTabIndex = 0;

  /* UseCases */
  final CheckAnswerWithStreamResponseUseCase checkAnswerWithStreamResponse;

  /* Controllers  */
  late final ScrollController firstTabScrollController;
  late final TextEditingController textEditingController;
  late final FocusNode focusNode;

  /* Intents */

  /// 상단 탭이 클릭 되었을 때
  void onTabTapped(int index) {
    selectedTabIndex = index;
    notifyListeners();
    onFocusKeyboard();
  }

  /// TextField에 글자가 입력 되었을 때
  void onFieldChanged(String term) {
    notifyListeners();
  }

  /// 가상 키보드 비활성화 (숨기기)
  void onFocusKeyboard() {
    if (focusNode.hasFocus) {
      focusNode.unfocus();
    }
  }

  /// 스크롤 위치 최적화, 채팅 메세지 추가 시
  /// 스크롤 위치 관련 info
  /// maxScrollExtent : 현재 ListView maxScroll 포지션 크기
  /// 48 : 기본 채팅 높이
  /// 17 * paragraphLine : 한 줄이 추가 될 때 마다 17 사이즈가 증가.
  void optimizeScrollPosition(int? paragraphLine) {
    // if (paragraphLine == null) {
    //   firstTabScrollController.animateTo(
    //     firstTabScrollController.position.maxScrollExtent,
    //     duration: const Duration(milliseconds: 300),
    //     curve: Curves.easeInOut,
    //   );
    //   return;
    // }
    // print("ARANG ${firstTabScrollController.position.maxScrollExtent}");
    //
    // firstTabScrollController.animateTo(
    //   firstTabScrollController.position.maxScrollExtent +
    //       48 +
    //       (17 * paragraphLine),
    //   duration: const Duration(milliseconds: 300),
    //   curve: Curves.easeInOut,
    // );
  }

  Future<void> onFieldSubmitted() async {
    chatList = [
      Chat(
        type: ChatMessageType.answerQuestion,
        message: textEditingController.text,
      ),
      ...chatList,
    ];
    notifyListeners();

    // final int lineCount = '\n'.allMatches(textEditingController.text).length;
    // optimizeScrollPosition(lineCount);

    await firstTabScrollController.animateTo(
      firstTabScrollController.position.minScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    textEditingController.text = '';
  }

  Future<void> addChatList() async {}

  /* Getters */
  // 입력창 전송 버튼 활성화 여부
  bool get isTextField => textEditingController.text.isNotEmpty;

  bool get showTextField => selectedTabIndex == 0;

  @override
  void onInit() {
    firstTabScrollController = ScrollController();
    textEditingController = TextEditingController();
    focusNode = FocusNode();

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        optimizeScrollPosition(null);
      }
    });
  }

  @override
  void onDispose() {
    textEditingController.dispose();
  }
}
