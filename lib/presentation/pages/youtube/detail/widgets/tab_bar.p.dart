part of '../youtube_detail_page.dart';

class _TabBar extends StatelessWidget {
  const _TabBar({super.key, required this.controller});

  final TabController controller;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Stack(
        children: [
          TabBar(
            controller: controller,
            dividerColor: Colors.white,
            tabs: [
              ...ContentsDetailTabType.values
                  .map(
                    (tab) => Tab(
                      text: tab.displayStr,
                    ),
                  )
                  .toList()
            ],
            indicator: TechtalkTabBar(width: (AppSize.screenWidth - 36) / 2),
            onTap: (_) {
              FocusScope.of(context).unfocus();
            },
            overlayColor: WidgetStateProperty.all<Color>(Colors.grey.shade200),
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
    );
  }
}
