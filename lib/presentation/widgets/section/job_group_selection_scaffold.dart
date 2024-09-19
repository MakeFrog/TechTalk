import 'package:flutter/material.dart';
import 'package:techtalk/core/services/app_size.dart';

class JobGroupSelectionScaffold extends StatelessWidget {
  const JobGroupSelectionScaffold({
    super.key,
    required this.introTextView,
    required this.selectedJogGroupSlider,
    required this.totalJobGroupListView,
    required this.bottomFixedBtn,
  });

  final Widget introTextView;
  final SliverPersistentHeaderDelegate selectedJogGroupSlider;
  final SliverList totalJobGroupListView;
  final Widget bottomFixedBtn;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: introTextView,
              ),
              SliverPersistentHeader(
                floating: true,
                pinned: true,
                delegate: selectedJogGroupSlider,
              ),
              totalJobGroupListView,
            ],
          ),
        ),
        Container(
          color: Colors.white,
          margin: EdgeInsets.only(bottom: AppSize.bottomInset == 0 ? 16 : 0),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: bottomFixedBtn,
        )
      ],
    );
  }
}
