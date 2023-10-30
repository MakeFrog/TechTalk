part of '../chat_page.dart';

class _AppBar extends ConsumerWidget implements PreferredSizeWidget {
  const _AppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      titleSpacing: 0,
      backgroundColor: AppColor.of.white,
      centerTitle: false,
      automaticallyImplyLeading: false,
      leadingWidth: 56,
      title: GestureDetector(
        onTap: () {
          /// TEST
          const SignUpRoute().go(ref.context);
        },
        child: Text(
          'Swift',
          style: AppTextStyle.headline2,
        ),
      ),
      leading: SizedBox(
        child: IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(Assets.iconsArrowLeft),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
