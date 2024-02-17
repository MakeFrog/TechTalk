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
              padding: const EdgeInsets.symmetric(horizontal: 20),
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
                  return TabBar(
                    controller: tabController,
                    tabs: const [
                      Tab(
                        text: '면접',
                      ),
                      Tab(
                        text: '문답',
                      ),
                    ],
                    indicator: UnderlineTabIndicator(
                      borderSide:
                          BorderSide(width: 2, color: AppColor.of.black),
                      insets: EdgeInsets.symmetric(
                        horizontal: AppSize.to.screenWidth / 4.2,
                      ),
                    ),
                    labelColor: AppColor.of.black,
                    unselectedLabelColor: AppColor.of.gray3,
                    indicatorColor: AppColor.of.black,
                    labelStyle: AppTextStyle.title3,
                    unselectedLabelStyle: AppTextStyle.body2,
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
