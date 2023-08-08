import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techtalk/app/resources/ui_config/app_insets.dart';
import 'package:techtalk/app/resources/ui_config/color_config.dart';
import 'package:techtalk/app/resources/ui_config/font_config.dart';
import 'package:techtalk/domain/useCase/chat/get_gpt_reply_use_case_old.dart';
import 'package:techtalk/main.dart';
import 'package:techtalk/presentation/base/base_screen.dart';
import 'package:techtalk/presentation/base/base_view.dart';
import 'package:techtalk/presentation/screens/chat/chat_view_model.dart';
import 'package:techtalk/presentation/screens/chat/local_widget/chat_list_tab_view.dart';


class ChatScreen extends BaseScreen<ChatViewModel> {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  ChatViewModel createViewModel() => ChatViewModel(
      getGptReplyUseCase: getIt.get<GetGptReplyUseCase>());

  @override
  Widget buildScreen(BuildContext context) {
    return DefaultTabController(
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
            child: const _TabBar(),
          ),
          const Expanded(
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                ChatListTabView(),
                SingleChildScrollView(
                  child: Placeholder(
                    fallbackHeight: 900,
                  ),
                ),
                SingleChildScrollView(
                  child: Placeholder(
                    fallbackHeight: 600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) => AppBar(
        elevation: 0,
        titleSpacing: 0,
        leading: IconButton(
          onPressed: () {
            print(vm(context).chatList.first.message.value);
          },
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

class _TabBar extends BaseView<ChatViewModel> {
  const _TabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBar(
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
    );
  }
}
