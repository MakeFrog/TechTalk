part of '../question_creation_page.dart';

class _IllustView extends ConsumerWidget
    with QuestionCreationState, QuestionCreationEvent {
  const _IllustView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return createdQnasAsync(ref).when(
      data: (_) {
        return HookBuilder(
          builder: (context) {
            useEffect(() {
              setQnaCompleter(ref);
            }, []);
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
        );
      },
      loading: _buildLoadingView,
      error: (e, _) {
        logger.e('질문 생성 중 오류 발생: $e');
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '질문 생성 중 오류가 발생했습니다',
                style: AppTextStyle.headline2,
                textAlign: TextAlign.center,
              ),
              const Gap(8),
              Text(
                e.toString(),
                style: AppTextStyle.body2,
                textAlign: TextAlign.center,
              ),
            ],
          ),
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
