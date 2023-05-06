import 'dart:async';
import 'package:flutter/material.dart';
import 'package:moon_dap/domain/useCase/chat/get_gpt_reply_use_case.dart';
import 'package:moon_dap/domain/enum/chat_message_type_enum.dart';
import 'package:moon_dap/domain/model/chat/chat.dart';
import 'package:moon_dap/presentation/base/base_view_model.dart';
import 'package:rxdart/rxdart.dart';

class ChatViewModel extends BaseViewModel {
  ChatViewModel({required this.checkAnswerWithStreamResponse});

  /* Data Variables */
  List<Chat> chatList = Chat.generate();

  List<Chat> get chatListed => chatList;
  List<int> tempState = [0, 1];

  /* State Variables */
  int selectedTabIndex = 0;

  /* UseCases */
  final GetGptReplyUseCase checkAnswerWithStreamResponse;

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

  /// 채팅이 입력되었을 때
  /// 역순(reversed)으로 데이터가 추가되어야 함에 유의
  Future<void> onFieldSubmitted() async {
    // 1. chat list에 첫 번째 배열 위치에 put
    chatList = [
      Chat(
        type: ChatMessageType.answerQuestion,
        message: BehaviorSubject.seeded(textEditingController.text),
      ),
      ...chatList,
    ];
    notifyListeners();

    // 2. 스크롤 최적화 위치
    // 가장 위에 스크롤 된 상태에서 채팅을 입력했을 때 최근 submit한 채팅 메세지가 보이도록
    // 스크롤 위치를 가장 아래 부분으로 변경
    await firstTabScrollController.animateTo(
      firstTabScrollController.position.minScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    await replyToUserAnswer(textEditingController.text);

    // replyToUserAnswer("");
    textEditingController.text = '';
  }

  Future<void> replyToUserAnswer(String userMessage) async {
    const String question = '프로토콜과 클래스의 차이를 설명해보세요';
    const String category = '[iOS]Swift';

    // 1. chat list에 첫 번째 배열 위치에 put
    chatList = [
      Chat(
          type: ChatMessageType.replyToUserAnswer,
          message: checkAnswerWithStreamResponse.getGptReplyOnStream(
              category: category, question: question, userAnswer: userMessage)),
      ...chatList,
    ];
    notifyListeners();
  }

  BehaviorSubject<String> getStream(String text) {
    final BehaviorSubject<String> messageSubject = BehaviorSubject<String>();
    int index = 0;

    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (index < text.length) {
        messageSubject.add(text.substring(0, index + 1));
        index++;
      } else {
        timer.cancel();
        messageSubject.close();
      }
    });

    return messageSubject;
  }

  /* Getters */
  // 입력창 전송 버튼 활성화 여부
  bool get isTextField => textEditingController.text.isNotEmpty;

  @override
  void onInit() {
    firstTabScrollController = ScrollController();
    textEditingController = TextEditingController();
    focusNode = FocusNode();
    checkAnswerWithStreamResponse.initUseCase();
  }

  @override
  void onDispose() {
    textEditingController.dispose();
  }
}
