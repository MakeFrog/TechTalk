part of '../youtube_detail_page.dart';

class _TabBar extends StatelessWidget {
  const _TabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: TabBar(
        labelColor: AppColor.of.black,
        unselectedLabelColor: AppColor.of.gray3,
        labelStyle: AppTextStyle.title3,
        unselectedLabelStyle: AppTextStyle.body2,
        indicator: UnderlineTabIndicator(
          borderSide: const BorderSide(width: 2.0),
          insets: EdgeInsets.symmetric(
            horizontal: AppSize.ratioWidth(
              162,
            ),
          ), // 인디케이터의 가로 여백 조정
        ),
        tabs: ContentsDetailTabType.values
            .map(
              (tab) => SizedBox(
                width: double.infinity,
                child: Tab(
                  text: tab.displayStr,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

///
/// 탭바
///
TabBar _buildTabBar() => TabBar(
      labelColor: Colors.black,
      unselectedLabelColor: Colors.grey,
      indicator: const UnderlineTabIndicator(
        borderSide: BorderSide(width: 2.0, color: Colors.black), // 인디케이터 두께와 색상
        insets: EdgeInsets.symmetric(horizontal: 70.0), // 인디케이터의 가로 여백 조정
      ),
      tabs: ContentsDetailTabType.values
          .map(
            (tab) => Tab(
              text: tab.displayStr,
            ),
          )
          .toList(),
    );
