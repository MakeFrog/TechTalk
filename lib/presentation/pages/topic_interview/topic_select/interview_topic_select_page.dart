import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/presentation/pages/topic_interview/topic_select/providers/topic_list_provider.dart';
import 'package:techtalk/presentation/pages/topic_interview/topic_select/widgets/topic_card.dart';

class InterviewTopicSelectPage extends StatelessWidget {
  const InterviewTopicSelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const _Body(),
    );
  }
}

class _Body extends HookWidget {
  const _Body({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTopic = useState<int?>(null);

    return SafeArea(
      minimum: EdgeInsets.only(bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoMessage(),
          _buildTopicListView(selectedTopic),
          _buildNextButton(selectedTopic),
        ],
      ),
    );
  }

  Widget _buildInfoMessage() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Text(
        'AI 면접을 진행할\n주제를 알려주세요',
        style: AppTextStyle.headline1,
      ),
    );
  }

  Widget _buildTopicListView(ValueNotifier<int?> selectedTopic) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 16.h),
        child: Consumer(
          builder: (context, ref, child) {
            final topicListAsync = ref.watch(topicListProvider);

            return topicListAsync.when(
              loading: SizedBox.new,
              error: (error, stackTrace) => Text('$error'),
              data: (data) {
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: ScreenUtil().screenWidth < 800 ? 2 : 3,
                    crossAxisSpacing: 11.w,
                    mainAxisSpacing: 12.w,
                  ),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final topic = data[index];
                    final isSelected = index == selectedTopic.value;

                    return TopicCard(
                      topic: topic,
                      isSelected: isSelected,
                      onTap: () {
                        if (isSelected) {
                          selectedTopic.value = null;
                        } else {
                          selectedTopic.value = index;
                        }
                      },
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildNextButton(ValueNotifier<int?> selectedTopic) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.r),
      child: FilledButton(
        onPressed: selectedTopic.value != null ? () {} : null,
        child: Center(
          child: Text('다음'),
        ),
      ),
    );
  }
}
