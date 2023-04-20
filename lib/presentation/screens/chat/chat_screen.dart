import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moon_dap/app/resources/uiConfig/app_insets.dart';
import 'package:moon_dap/app/resources/uiConfig/app_space_config.dart';
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
  Widget? buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        vm(context).onFieldChanged("term");
      },
    );
  }

  @override
  Widget buildScreen(BuildContext context) {
    print("BUILD SCIRPT CHATS");
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
                  Selector(
                    selector: (BuildContext context, ChatViewModel vm) =>
                        vm.chatList,
                    builder: (context, chatList, child) {
                      return ListView.builder(
                        itemCount: chatList.length,
                        itemBuilder: (_, index) {
                          return NewChatBubble(
                              messageType: chatList[index].type,
                              message: chatList[index].message);
                        },
                      );
                    },
                  ),
                  Container(
                    color: Colors.yellow,
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

      //
      Positioned(
        bottom: 0,
        child: Container(
          width: SizeConfig.to.screenWidth,
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(
                color: Color(0xFFE5E5EA),
              ),
            ),
          ),
          child: Consumer<ChatViewModel>(builder: (context, _, __) {
            print("TEXT FEILD SECTION");
            return AnimatedOpacity(
              opacity: vm(context).selectedTabIndex == 0 ? 1 : 0,
              duration: const Duration(milliseconds: 300),
              child: Stack(
                children: [
                  TextField(
                    onChanged: vm(context).onFieldChanged,
                    controller: vm(context).textEditingController,
                    maxLines: null,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding:
                          const EdgeInsets.only(right: 42, left: 16, top: 18),
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
                                    : const Color(0xFFBDBDC2)),
                            BlendMode.srcIn),
                      ),
                      onPressed: vm(context).onFieldSubmitted,
                    ),
                  ),
                ],
              ),
            );
          }),
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
