import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moon_dap/app/resources/uiConfig/app_insets.dart';
import 'package:moon_dap/app/resources/uiConfig/color_config.dart';
import 'package:moon_dap/app/resources/uiConfig/font_config.dart';
import 'package:moon_dap/presentation/base/base_screen.dart';
import 'package:moon_dap/presentation/screens/chat/chat_view_model.dart';

class ChatScreen extends BaseScreen<ChatViewModel> {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  ChatViewModel createViewModel() => ChatViewModel();

  @override
  Widget buildScreen(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: <Widget>[
          Container(
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
              onTap: (index) {},
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
              children: [
                ListView(
                  children: <Widget>[],
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
          "Sasdfwiftasdf 100문 100답, 면접 단골 질문 면접 면접 면접",
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
