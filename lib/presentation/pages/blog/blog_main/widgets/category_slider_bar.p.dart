part of '../blog_main_page.dart';

class _CategorySliderBar extends ConsumerWidget with BlogMainState {
  const _CategorySliderBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: AppColor.of.background1,
      height: 58,
      child: ListView.separated(
        padding: const EdgeInsets.only(left: 16, right: 32),
        scrollDirection: Axis.horizontal,
        itemCount: totalCategories(ref).length,
        separatorBuilder: (_, __) => const Gap(8),
        itemBuilder: (context, index) {
          final category = totalCategories(ref)[index];
          return SelectableCategoryChip(
            isSelected: selectedCategory(ref).id == category.id,
            onTap: () {
              // ref.read(selectedBlogSkillProvider.notifier).state = skill.id;
            },
            item: category,
          );
        },
      ),
    );
  }
}
