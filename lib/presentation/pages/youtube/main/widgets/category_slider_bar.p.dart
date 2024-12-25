part of '../youtube_content_main_page.dart';

class _CategorySliderBar extends ConsumerWidget
    with YoutubeContentMainState, YoutubeContentMainEvent {
  const _CategorySliderBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Colors.white,
      child: Center(
        child: ListView.separated(
          padding: const EdgeInsets.only(left: 16, right: 32),
          scrollDirection: Axis.horizontal,
          itemCount: totalCategories(ref).length,
          separatorBuilder: (_, __) => const Gap(8),
          itemBuilder: (context, index) {
            final category = totalCategories(ref)[index];
            return SelectableChip(
              isSelected: category.id == selectedCategory(ref).id,
              onTap: () {
                onCategoryChipTapped(ref, targetCategory: category);
              },
              imagePath: category.imagePath,
              label: category.name,
            );
          },
        ),
      ),
    );
  }
}
