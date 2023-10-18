import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:techtalk/_backup/domain/enum/chat_message_type_enum.dart';
import 'package:techtalk/_backup/domain/model/chat/Correctness.dart';
import 'package:techtalk/_backup/domain/model/chat/chat.dart';
import 'package:techtalk/_backup/domain/model/question/question.dart';
import 'package:techtalk/_backup/domain/useCase/chat/get_gpt_reply_use_case_old.dart';

class ChatViewModel extends BaseViewModel {
  ChatViewModel({required this.getGptReplyUseCase});

  /* Data Variables */
  List<Chat> chatList = Chat.generate();
  List<Question> questionList = Question.generate();

  /* State Variables */
  int selectedTabIndex = 0;
  int currentQuestionIndex = 0;
  List<int> tempState = [0, 1];

  /* UseCases */
  final GetGptReplyUseCase getGptReplyUseCase;

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
    // 0. TextField 활성화 상태가 아니라면 리턴
    if (!isTextFieldActivated) {
      return;
    }

    DateTime now = DateTime.now();

    // 1. chat list에 첫 번째 배열 위치에 put
    chatList = [
      Chat.sender(
        type: ChatMessageType.answerQuestion,
        message: BehaviorSubject.seeded(textEditingController.text),
        sendTime: now,
        correctness: Correctness.checking,
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

  // 첫 번째 질문 제시
  void showFirstQuestion() {
    chatList = [
      Chat(
        type: ChatMessageType.askQuestion,
        message: returnToStream("첫 번째 질문입니다.\n${currentQuestion.question}"),
      ),
      ...chatList,
    ];
    notifyListeners();
  }

  // 다음 질문 제시
  Future<void> showNestQuestion() async {
    currentQuestionIndex++;
    // await checkAnswer();
    chatList = [
      Chat(
        type: ChatMessageType.askQuestion,
        message: returnToStream("다음 질문입니다\n${currentQuestion.question}"),
      ),
      ...chatList,
    ];
    notifyListeners();
  }

  /// 정답 여부 확인 및 상태 변경
  void checkUserAnswer(bool isCorrect) {
    final index =
        chatList.indexWhere((element) => !element.type.isReceiverType);

    if (isCorrect) {
      chatList[index].correctness = Correctness.correct;
    } else {
      chatList[index].correctness = Correctness.incorrect;
    }
    notifyListeners();
  }

  // 유저의 답변에 대한 gpt응답
  Future<void> replyToUserAnswer(String userMessage) async {
    // 1. chat list에 첫 번째 배열 위치에 put

    chatList = [
      Chat(
        type: ChatMessageType.replyToUserAnswer,
        message: getGptReplyUseCase.call(
          (
            category: currentQuestion.category,
            question: currentQuestion.question,
            userAnswer: userMessage,
            onStreamDone: showNestQuestion,
            checkAnswer: checkUserAnswer
          ),
        ),
      ),
      ...chatList,
    ];
    notifyListeners();
  }

  // 문자열을 받으면 Stream형태로 변환해주는 메소드
  BehaviorSubject<String> returnToStream(String text) {
    final BehaviorSubject<String> messageSubject = BehaviorSubject<String>();
    int index = 0;

    Timer.periodic(const Duration(milliseconds: 50), (timer) {
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

  /// 입력창 전송 버튼 활성화 여부
  /// 1. TextField 입력 글자 존재 여부
  /// 2. ChatGpt 응답 진행 여부
  bool get isTextFieldActivated =>
      textEditingController.text.isNotEmpty &&
      getGptReplyUseCase.state == ReplyState.init;

  // 현재 진행중인 질문
  Question get currentQuestion => questionList[currentQuestionIndex];

  @override
  void onInit() {
    firstTabScrollController = ScrollController();
    textEditingController = TextEditingController();
    focusNode = FocusNode();
    getGptReplyUseCase.initUseCase();
    showFirstQuestion();
  }

  @override
  void onDispose() {
    textEditingController.dispose();
  }
}
