part of '../proficiency_question_creation_page.dart';

class _IllustView extends ConsumerWidget with ProficiencyQuestionCreationState {
  const _IllustView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return createdQnasAsync(ref).when(
      data: (_) {
        return FutureBuilder(
          future: Future.delayed(const Duration(milliseconds: 160)),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox.shrink();
            }
            return Center(
              child: Lottie.asset(
                repeat: false,
                Assets.lottieDone,
                fit: BoxFit.fitWidth,
              ),
            );
          },
        );
      },
      loading: _buildLoadingView,
      error: (e, _) {
        return HookBuilder(
          builder: (context) {
            useEffect(() {
              DialogService.show(
                dismissible: false,
                dialog: AppDialog.singleBtn(
                  title: '오류 발생',
                  description: '$e',
                  onBtnClicked: () {},
                ),
              );
            }, []);
            return _buildLoadingView();
          },
        );
      },
    );
  }

  Widget _buildLoadingView() {
    return Center(
      child: Transform.scale(
        scale: 1.28, // 로티를 그대로 적용하면 디자인 시안과 안맞기 위해 임의로 scale를 줌
        child: Lottie.asset(
          Assets.lottieDocumentLoading,
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}
