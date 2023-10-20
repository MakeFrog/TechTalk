import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/presentation/pages/topic_interview/topic_select/widgets/topic_card.dart';

class TopicSelectPage extends StatelessWidget {
  const TopicSelectPage({super.key});

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
      minimum: EdgeInsets.only(bottom: 16),
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
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        'AI 면접을 진행할\n주제를 알려주세요',
        style: AppTextStyle.headline1,
      ),
    );
  }

  Widget _buildTopicListView(ValueNotifier<int?> selectedTopic) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 11,
            mainAxisSpacing: 12,
          ),
          itemCount: 10,
          itemBuilder: (context, index) {
            return TopicCard(
              isSelected: index == selectedTopic.value,
              onTap: () {
                selectedTopic.value = index;
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildNextButton(ValueNotifier<int?> selectedTopic) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: FilledButton(
        onPressed: selectedTopic.value != null ? () {} : null,
        child: Center(
          child: Text('다음'),
        ),
      ),
    );
  }
}
