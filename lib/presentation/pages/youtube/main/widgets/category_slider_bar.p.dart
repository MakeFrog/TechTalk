part of '../youtube_main_page.dart';

class _CategorySliderBar extends ConsumerWidget
    with YoutubeMainState, YoutubeMainEvent {
  const _CategorySliderBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      // color: Colors.red,
      color: AppColor.of.background1,
      height: 58,
      child: SizedBox(
        child: ListView.separated(
          shrinkWrap: true,
          padding: const EdgeInsets.only(left: 16, right: 32),
          scrollDirection: Axis.horizontal,
          itemCount: totalCategories(ref).length,
          separatorBuilder: (_, __) => const Gap(8),
          itemBuilder: (context, index) {
            final category = totalCategories(ref)[index];

            return SelectableCategoryChip(
              isSelected: category.id == selectedCategory(ref).id,
              onTap: () {
                onCategoryChipTapped(ref,
                    targetCategory: category, index: index);
              },
              item: category,
            );
          },
        ),
      ),
    );
  }
}
