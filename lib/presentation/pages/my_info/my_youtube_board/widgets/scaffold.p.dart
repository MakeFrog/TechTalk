part of '../my_youtube_board_page.dart';

class _Scaffold extends StatelessWidget {
  const _Scaffold({
    super.key,
    required this.tabBar,
    required this.watchedHistoryTabView,
    required this.bookmarkedTabView,
    required this.uploadedContentTabView,
  });

  final Widget tabBar;
  final Widget watchedHistoryTabView;
  final Widget bookmarkedTabView;
  final Widget uploadedContentTabView;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: YoutubeBoardTabType.values.length,
      child: Column(
        children: [
          Stack(
            children: [
              TabBar(
                dividerColor: Colors.white,
                tabs: [
                  ...YoutubeBoardTabType.values
                      .map(
                        (tab) => Tab(
                          text: tab.label,
                        ),
                      )
                      .toList()
                ],
                indicator:
                    TechtalkTabBar(width: (AppSize.screenWidth - 36) / 3),
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
          Expanded(
            child: TabBarView(
              children: [
                SingleChildScrollView(
                  child: watchedHistoryTabView,
                ),
                SingleChildScrollView(
                  child: bookmarkedTabView,
                ),
                SingleChildScrollView(
                  child: uploadedContentTabView,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
