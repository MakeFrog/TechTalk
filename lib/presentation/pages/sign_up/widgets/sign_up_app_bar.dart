part of '../sign_up_page.dart';

class _AppBar extends StatelessWidget
    with SignUpEvent, SignUpState
    implements PreferredSizeWidget {
  const _AppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      leading: _buildBackButton(),
      actions: [
        _buildStepIndicator(),
      ],
    );
  }

  Widget _buildBackButton() {
    return HookConsumer(
      builder: (context, ref, child) {
        final pageController = signUpStepController(ref);
        final canBack = useListenableSelector(
          pageController,
          () =>
              pageController.hasClients &&
              (pageController.page?.round() ?? 0) >= 1,
        );

        return canBack
            ? AppBackButton(
                onBackBtnTapped: () => onTapBackButton(ref),
              )
            : const SizedBox();
      },
    );
  }

  Widget _buildStepIndicator() {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Consumer(
        builder: (_, ref, __) {
          return SmoothPageIndicator(
            controller: signUpStepController(ref),
            count: 3,
            effect: WormEffect(
              type: WormType.thin,
              activeDotColor: AppColor.of.brand2,
              dotColor: AppColor.of.brand1,
              dotHeight: 8,
              dotWidth: 8,
            ),
          );
        },
      ),
    );
  }
}
