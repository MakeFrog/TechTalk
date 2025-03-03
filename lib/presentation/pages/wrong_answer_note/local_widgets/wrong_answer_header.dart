part of '../wrong_answer_note_page.dart';

class _WrongAnswerHeader extends HookWidget
    with WrongAnswerNoteState, WrongAnswerNoteEvent
    implements PreferredSizeWidget {
  const _WrongAnswerHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(102),
      child: Consumer(
        builder: (context, ref, child) {
          return HookBuilder(
            builder: (context) {
              final isFold = useState(false);

              scrollController(ref).addListener(
                () {
                  final scrollPosition = scrollController(ref).offset;

                  if (WrongAnswerNoteScrollController.animatedOffset <
                          scrollPosition &&
                      !isFold.value) {
                    isFold.value = true;
                    return;
                  }

                  if (WrongAnswerNoteScrollController.animatedOffset >=
                          scrollPosition &&
                      isFold.value) {
                    isFold.value = false;
                    return;
                  }
                },
              );
              return AnimatedContainer(
                height: isFold.value ? 0 : 112,
                duration: const Duration(milliseconds: 200),
                child: AnimatedOpacity(
                  opacity: isFold.value ? 0 : 1,
                  duration: const Duration(milliseconds: 200),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: BackButtonAppBar(
                          title: tr(LocaleKeys.learning_reviewNote),
                        ),
                      ),
                      Positioned(
                        bottom: 12,
                        left: 0,
                        right: 0,
                        child: SizedBox(
                          height: 32,
                          child: ListView.separated(
                            padding: const EdgeInsets.only(left: 12, right: 24),
                            scrollDirection: Axis.horizontal,
                            itemCount: userTopicRecords(ref).length,
                            separatorBuilder: (context, index) => const Gap(8),
                            itemBuilder: (context, index) {
                              final topic = userTopicRecords(ref)[index];
                              final isSelected =
                                  topic.id == selectedTopic(ref)!.id;

                              return SelectableChip(
                                isSelected: isSelected,
                                onTap: () => onTapTopicChip(
                                  ref,
                                  topic,
                                ),
                                label: topic.text,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(112);
}
