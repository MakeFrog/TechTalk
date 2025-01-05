part of '../youtube_detail_page.dart';

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
