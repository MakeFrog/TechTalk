part of '../chat_page.dart';

class _Scaffold extends StatelessWidget {
  const _Scaffold({
    Key? key,
    required this.chatTabView,
    required this.summaryTabView,
    required this.tabController,
    required this.watchView,
  }) : super(key: key);

  final Widget chatTabView;
  final Widget summaryTabView;
  final Widget watchView;
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
              child: ColoredBox(
                color: Colors.white,
                child: Stack(
                  children: [
                    TabBar(
                      controller: tabController,
                      dividerColor: Colors.white,
                      tabs: [
                        ...[
                          LocaleKeys.common_interviewTerms_interview,
                          LocaleKeys.common_interviewTerms_qa
                        ]
                            .map(
                              (tab) => Tab(
                                text: tr(tab),
                              ),
                            )
                            .toList()
                      ],
                      indicator:
                          TechtalkTabBar(width: (AppSize.screenWidth - 36) / 2),
                      onTap: (_) {
                        FocusScope.of(context).unfocus();
                      },
                      overlayColor:
                          WidgetStateProperty.all<Color>(Colors.grey.shade200),
                      labelColor: AppColor.of.black,
                      unselectedLabelColor: AppColor.of.gray3,
                      indicatorColor: AppColor.of.black,
                      labelStyle: AppTextStyle.title3,
                      unselectedLabelStyle: AppTextStyle.body2,
                    ),

                    /// DIVIDER
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 0.5,
                        color: AppColor.of.gray2,
                        width: double.infinity,
                      ),
                    ),
                  ],
                ),
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
        ),
        watchView,
      ],
    );
  }
}
