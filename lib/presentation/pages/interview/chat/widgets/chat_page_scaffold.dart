part of '../chat_page.dart';

class _Scaffold extends StatelessWidget {
  const _Scaffold({
    Key? key,
    required this.chatTabView,
    required this.summaryTabView,
    required this.tabController,
  }) : super(key: key);

  final Widget chatTabView;
  final Widget summaryTabView;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 0.5,
                    color: AppColor.of.gray2,
                  ),
                ),
              ),
              child: Builder(
                builder: (context) {
                  return SizedBox(
                    height: ChatPage.tabBarHeight,
                    child: TabBar(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      controller: tabController,
                      tabs: [
                       Tab(text: tr(LocaleKeys.common_interviewTerms_interview)),
                        Tab(text: tr(LocaleKeys.common_interviewTerms_qa)),
                      ],
                      indicator: UnderlineTabIndicator(
                        borderSide:
                            BorderSide(width: 2, color: AppColor.of.black),
                        insets: EdgeInsets.symmetric(
                          horizontal: AppSize.to.screenWidth / 4.2,
                        ),
                      ),
                      onTap: (_) {
                        FocusScope.of(context).unfocus();
                      },
                      overlayColor: MaterialStateProperty.all<Color>(
                          Colors.grey.shade200),
                      labelColor: AppColor.of.black,
                      unselectedLabelColor: AppColor.of.gray3,
                      indicatorColor: AppColor.of.black,
                      labelStyle: AppTextStyle.title3,
                      unselectedLabelStyle: AppTextStyle.body2,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: [
              chatTabView,
              summaryTabView,
            ],
          ),
        )
      ],
    );
  }
}
