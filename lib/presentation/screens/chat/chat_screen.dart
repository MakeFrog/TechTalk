import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moon_dap/app/resources/uiConfig/app_insets.dart';
import 'package:moon_dap/app/resources/uiConfig/app_space_config.dart';
import 'package:moon_dap/app/resources/uiConfig/color_config.dart';
import 'package:moon_dap/app/resources/uiConfig/font_config.dart';
import 'package:moon_dap/app/resources/uiConfig/size_config.dart';
import 'package:moon_dap/chatGptTest/useCase/check_answer_with_stream_response_use_case.dart';
import 'package:moon_dap/domain/model/chat/chat.dart';
import 'package:moon_dap/main.dart';
import 'package:moon_dap/presentation/base/base_screen.dart';
import 'package:moon_dap/presentation/common/bubble/new_chat_bubble.dart';
import 'package:moon_dap/presentation/screens/chat/chat_view_model.dart';
import 'package:provider/provider.dart';

/** NOTE
 *  1. HOLIX 서비스 TextField Expand 기능 고려
 *
 * */

/** Todo List, 4/19
 *  1. TextField Suffix Button toggle 로직 ✅
 *  2. [ListView.builder] 기반 chat buuble expose 로직 ✅
 *  3. content inset 설정하기 ✅
 * */

/** Todo List, 4/20
 * 1. Consumer && Provider or Selector 렌더링 포퍼먼스 비교 ✅
 * R : Selector가 리렌더링을 최적화하는 방법
 *
 * */

/** Todo List, 4/25
 * 1. 가상 키보드 인터렉션 로직 고도화 (focus Node) ✅
 * 2. 채팅 message 레이아웃 조정
 * 3. Clean UI 코드 적용. 구조화
 * 4. StreamBuilder Chat gpt 응답 고도화
 * */

class ChatScreen extends BaseScreen<ChatViewModel> {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  ChatViewModel createViewModel() => ChatViewModel(
      checkAnswerWithStreamResponse:
          getIt.get<CheckAnswerWithStreamResponseUseCase>());

  @override
  Widget buildScreen(BuildContext context) {
    print(SizeConfig.to.screenHeight);
    print(SizeConfig.to.bottomInset);
    print(SizeConfig.to.statusBarHeight);
    return SingleChildScrollView(
      child: DefaultTabController(
        length: 3,
        child: Column(
          children: <Widget>[
            Container(
              height: 38,
              padding: AppInset.horizontal8,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 0.8, color: Color(0xFFE0E0E5)),
                ),
              ),
              child: TabBar(
                labelColor: AppColor.blue,
                unselectedLabelColor: AppColor.lightGrey,
                indicatorColor: Colors.blue,
                labelStyle: AppTextStyle.title3,
                unselectedLabelStyle: AppTextStyle.body2,
                onTap: vm(context).onTabTapped,
                tabs: const <Tab>[
                  Tab(
                    text: '문답',
                  ),
                  Tab(
                    text: '정보',
                  ),
                  Tab(
                    text: '진행상황',
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                Container(
                  color: Colors.yellow,
                  // top inset - appbar(56) - tab hegiht(38) - TextField Height(48)
                  height: SizeConfig.to.screenHeight -
                      56 -
                      38 -
                      SizeConfig.to.statusBarHeight -
                      48,
                  child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      SingleChildScrollView(
                        child: Stack(
                          children: [
                            GestureDetector(
                              onTap: vm(context).onFocusKeyboard,
                              child: Selector<ChatViewModel, List<Chat>>(
                                // Selector 위젯으로 변경
                                selector:
                                    (BuildContext context, ChatViewModel vm) {
                                  return vm.chatList;
                                },
                                builder: (context, chatList, child) {
                                  // chatList만을 인자로 받도록 수정
                                  return Align(
                                    alignment: Alignment.bottomCenter,
                                    child: ListView.separated(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      controller:
                                          vm(context).firstTabScrollController,
                                      padding: AppInset.top12 +
                                          AppInset.horizontal12 + AppInset.bottom64,
                                      itemCount: chatList.length,
                                      itemBuilder: (_, index) {
                                        return NewChatBubble(
                                          messageType: chatList[index].type,
                                          message: chatList[index].message,
                                        );
                                      },
                                      separatorBuilder: (_, __) =>
                                          AppSpace.size14,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        child: Container(
                          color: Colors.yellow,
                        ),
                      ),
                      SingleChildScrollView(
                        child: Container(
                          color: Colors.yellow,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: AnimatedOpacity(
                    opacity:
                        vmS(context, (value) => value.showTextField ? 1 : 0),
                    duration: const Duration(milliseconds: 300),
                    child: Container(
                      constraints: const BoxConstraints(minHeight: 48),
                      width: SizeConfig.to.screenWidth,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        border: Border(
                          top: BorderSide(
                            color: Color(0xFFE5E5EA),
                          ),
                        ),
                      ),
                      child: Stack(
                        children: [
                          TextField(
                            focusNode: vm(context).focusNode,
                            onChanged: vm(context).onFieldChanged,
                            controller: vm(context).textEditingController,
                            maxLines: null,
                            textAlignVertical: TextAlignVertical.top,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.only(
                                right: 42,
                                left: 16,
                                top: 18,
                              ),
                              // ⚠️ suffix icon의 inkwell 효과를 고려하고 싶다면, TextField의 Color를 trasnparent로 설정해야됨
                              hintText: '답변을 입력하세요',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                          // suffix 전송 버튼
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: IconButton(
                              icon: SvgPicture.asset(
                                "assets/icons/send.svg",
                                colorFilter: ColorFilter.mode(
                                  vmS(
                                    context,
                                    (value) => value.isTextField
                                        ? AppColor.blue
                                        : const Color(0xFFBDBDC2),
                                  ),
                                  BlendMode.srcIn,
                                ),
                              ),
                              onPressed: vm(context).onFieldSubmitted,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) => AppBar(
        elevation: 0,
        titleSpacing: 0,
        leading: IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            "assets/icons/arrow_left.svg",
            height: 24,
            width: 24,
          ),
        ),
        title: Text(
          "Swift 100문 100답, 면접 단골 질문 면접 면접 면접",
          style: AppTextStyle.title2.copyWith(
              fontFamily: "pretendard_regular",
              overflow: TextOverflow.ellipsis),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              "assets/icons/more_circle.svg",
              width: 24,
              height: 24,
            ),
          ),
        ],
        backgroundColor: AppColor.white,
      );
}
