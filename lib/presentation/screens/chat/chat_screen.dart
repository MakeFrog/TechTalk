import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moon_dap/app/resources/uiConfig/app_insets.dart';
import 'package:moon_dap/app/resources/uiConfig/color_config.dart';
import 'package:moon_dap/app/resources/uiConfig/font_config.dart';
import 'package:moon_dap/app/resources/uiConfig/size_config.dart';
import 'package:moon_dap/domain/enum/chat_message_type_enum.dart';
import 'package:moon_dap/presentation/base/base_screen.dart';
import 'package:moon_dap/presentation/common/bubble/new_chat_bubble.dart';
import 'package:moon_dap/presentation/screens/chat/chat_view_model.dart';
import 'package:provider/provider.dart';

/** NOTE
 *  1. HOLIX 서비스 TextField Expand 기능 고려
 *
 * */

/** Todo List, 4/19
 *  1. TextField Suffix Button toggle 로직
 *  2. [ListView.builder] 기반 chat buuble expose 로직
 *  3. content inset 설정하기
 * */

class ChatScreen extends BaseScreen<ChatViewModel> {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  ChatViewModel createViewModel() => ChatViewModel();

  @override
  bool get wrapWithSafeArea => true;


  @override
  bool get setBottomSafeArea => true;

  @override
  FloatingActionButtonLocation? get floatingActionButtonLocation =>
      FloatingActionButtonLocation.centerDocked;

  /// 하단 고정 입력창
  // @override
  // Widget? buildFloatingActionButton(BuildContext context) {
  //   print("BOTTOM IONSET ==> ${SizeConfig.to.bottomInset}");
  //   return Consumer<ChatViewModel>(
  //     builder: (context, value, child) =>
  //         AnimatedOpacity(
  //           opacity: vm(context).selectedTabIndex == 0 ? 1 : 0,
  //           duration: const Duration(milliseconds: 300),
  //           child: BottomAppBar(
  //             notchMargin: 140.0,
  //             child: Stack(
  //               children: [
  //                 Container(
  //                   decoration: const BoxDecoration(
  //                     border: Border(
  //                       top: BorderSide(
  //                         color: Color(0xFFE5E5EA),
  //                       ),
  //                     ),
  //                   ),
  //                   child: TextField(
  //                     onChanged: vm(context).onFieldChanged,
  //                     controller: vm(context).textEditingController,
  //                     maxLines: null,
  //                     textAlignVertical: TextAlignVertical.top,
  //                     decoration: InputDecoration(
  //                       border: InputBorder.none,
  //                       contentPadding: const EdgeInsets.only(
  //                           right: 42, left: 16),
  //                       filled: true,
  //                       fillColor: Colors.transparent,
  //                       // fillColor: Colors.transparent,
  //                       // ⚠️ suffix icon의 inkwell 효과를 고려하고 싶다면, TextField의 Color를 trasnparent로 설정해야됨
  //                       hintText: '답변을 입력하세요',
  //                       enabledBorder: OutlineInputBorder(
  //                         borderSide: BorderSide.none,
  //                         borderRadius: BorderRadius.circular(8.0),
  //                       ),
  //                       focusedBorder: OutlineInputBorder(
  //                         borderSide: BorderSide.none,
  //                         borderRadius: BorderRadius.circular(8.0),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //
  //                 // suffix 전송 버튼
  //                 Positioned(
  //                   bottom: 0,
  //                   right: 0,
  //                   child: IconButton(
  //                     icon: SvgPicture.asset(
  //                       "assets/icons/send.svg",
  //                       colorFilter: ColorFilter.mode(
  //                           vmS(
  //                               context,
  //                                   (value) =>
  //                               value.isTextField
  //                                   ? AppColor.blue
  //                                   : const Color(0xFFBDBDC2)),
  //                           BlendMode.srcIn),
  //                     ),
  //                     onPressed: () {
  //                       debugPrint('click bait');
  //                     },
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //   );
  // }

  @override
  Widget buildScreen(BuildContext context) {
    return Stack(children: [
      DefaultTabController(
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
            Expanded(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  ListView(
                    padding: AppInset.left8 + AppInset.right16 + AppInset.top16,
                    children: const <Widget>[
                      NewChatBubble(
                        messageType: ChatMessageType.answerQuestion,
                        message:
                            "어쩌구 저쩌구 입니다. 그래서 어쩌구 저쩌구를 하면 저쩌구가 될 수 있을 것 같아요",
                        child: Text(
                          "어쩌구 저쩌구 입니다. 그래서 어쩌구 저쩌구를 하면 저쩌구가 될 수 있을 것 같아요",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      NewChatBubble(
                        messageType: ChatMessageType.replyToAnswer,
                        message:
                            "오답입니다\n Swift에서 upcasting과 downcasting의 개념을 이해하는 데 도움이 될 수 있지만, 불완전하거나 정확하지 않은 부분이 있습니다. 해당 답변은 Swift에서 upcasting과 downcasting의 개념을 이해하는 데 도움이 될 수 있지만, 불완전하거나 정확하지 않은 부분이 있습니다.  upcasting은 서로 상속 관계에 있는 클래스에서  자식 클래스를 부모 클래스로 타입캐스팅하는 것을 맞습니다.",
                        child: Text(
                          "오답입니다\n Swift에서 upcasting과 downcasting의 개념을 이해하는 데 도움이 될 수 있지만, 불완전하거나 정확하지 않은 부분이 있습니다. 해당 답변은 Swift에서 upcasting과 downcasting의 개념을 이해하는 데 도움이 될 수 있지만, 불완전하거나 정확하지 않은 부분이 있습니다.  upcasting은 서로 상속 관계에 있는 클래스에서  자식 클래스를 부모 클래스로 타입캐스팅하는 것을 맞습니다.",
                        ),
                      ),
                      NewChatBubble(
                        messageType: ChatMessageType.answerQuestion,
                        message:
                            "어쩌구 저쩌구 입니다. 그래서 어쩌구 저쩌구를 하면 저쩌구가 될 수 있을 것 같아요",
                        child: Text(
                          "어쩌구 저쩌구 입니다. 그래서 어쩌구 저쩌구를 하면 저쩌구가 될 수 있을 것 같아요",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      NewChatBubble(
                        messageType: ChatMessageType.replyToAnswer,
                        message:
                            "오답입니다\n Swift에서 upcasting과 downcasting의 개념을 이해하는 데 도움이 될 수 있지만, 불완전하거나 정확하지 않은 부분이 있습니다. 해당 답변은 Swift에서 upcasting과 downcasting의 개념을 이해하는 데 도움이 될 수 있지만, 불완전하거나 정확하지 않은 부분이 있습니다.  upcasting은 서로 상속 관계에 있는 클래스에서  자식 클래스를 부모 클래스로 타입캐스팅하는 것을 맞습니다.",
                        child: Text(
                          "오답입니다\n Swift에서 upcasting과 downcasting의 개념을 이해하는 데 도움이 될 수 있지만, 불완전하거나 정확하지 않은 부분이 있습니다. 해당 답변은 Swift에서 upcasting과 downcasting의 개념을 이해하는 데 도움이 될 수 있지만, 불완전하거나 정확하지 않은 부분이 있습니다.  upcasting은 서로 상속 관계에 있는 클래스에서  자식 클래스를 부모 클래스로 타입캐스팅하는 것을 맞습니다.",
                        ),
                      ),
                      NewChatBubble(
                        messageType: ChatMessageType.answerQuestion,
                        message:
                            "어쩌구 저쩌구 입니다. 그래서 어쩌구 저쩌구를 하면 저쩌구가 될 수 있을 것 같아요",
                        child: Text(
                          "어쩌구 저쩌구 입니다. 그래서 어쩌구 저쩌구를 하면 저쩌구가 될 수 있을 것 같아요",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    color: Colors.blue,
                  ),
                  Container(
                    color: Colors.yellow,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      Positioned(
        bottom: 0,
        child: Container(
          color: Colors.white,
          width: SizeConfig.to.screenWidth,
          child: Consumer<ChatViewModel>(
            builder: (context, value, child) => AnimatedOpacity(
              opacity: vm(context).selectedTabIndex == 0 ? 1 : 0,
              duration: const Duration(milliseconds: 300),
              child: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Color(0xFFE5E5EA),
                        ),
                      ),
                    ),
                    child: TextField(
                      onChanged: vm(context).onFieldChanged,
                      controller: vm(context).textEditingController,
                      maxLines: null,
                      textAlignVertical: TextAlignVertical.top,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                            const EdgeInsets.only(right: 42, left: 16, top: 18),
                        filled: true,
                        fillColor: Colors.transparent,
                        // fillColor: Colors.transparent,
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
                                    : const Color(0xFFBDBDC2)),
                            BlendMode.srcIn),
                      ),
                      onPressed: () {
                        debugPrint('click bait');
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ]);
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
