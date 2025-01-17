part of 'package:techtalk/presentation/pages/resume_manage/resume_manage_page.dart';

///
/// ResumeCard 위젯
/// 이력서, 포트폴리오 또는 데이터 없는 상태를 처리
///
class ResumeCard extends ConsumerWidget with ResumeManageEvent {
  const ResumeCard._({Key? key, this.doc, required this.type})
      : super(key: key);

  final DocumentBaseEntity? doc;
  final DocumentType type;

  ///
  /// RESUME
  ///
  factory ResumeCard.resume({
    required ResumeEntity resume,
  }) {
    return ResumeCard._(doc: resume, type: DocumentType.resume);
  }

  ///
  /// PORTFOLIO
  ///
  factory ResumeCard.portfolio({
    required PortfolioEntity portfolio,
  }) {
    return ResumeCard._(doc: portfolio, type: DocumentType.portfolio);
  }

  ///
  /// EMPTY
  ///
  factory ResumeCard.empty({
    required DocumentType type,
  }) {
    return ResumeCard._(type: type);
  }

  ///
  /// 상황에 맞게 분기해주는 메서드
  ///
  factory ResumeCard.fromData({
    required DocumentType type,
    required DocumentBaseEntity? doc,
  }) {
    // 만약 doc 이 없다면 => empty
    if (doc == null || doc.path!.isEmpty) {
      return ResumeCard.empty(type: type);
    }
    // doc 이 있다면 => resume or portfolio
    switch (type) {
      case DocumentType.resume:
        return ResumeCard.resume(resume: doc as ResumeEntity);
      case DocumentType.portfolio:
        return ResumeCard.portfolio(portfolio: doc as PortfolioEntity);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 데이터가 없으면 Placeholder 표시
    if (doc == null) {
      return FileUploadCard(type: type);
    }

    final title = doc?.title ?? '제목 없음';
    final date = doc?.uploadAt ?? '업로드 날짜 없음';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Gap(12),
        Text(
          type == DocumentType.resume ? '이력서' : '포트폴리오',
          style: AppTextStyle.headline2,
        ),
        const Gap(8),
        BounceTapper(
          highlightColor: Colors.transparent,
          onTap: () => onRegisteredFileBtnTapped(ref, type),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.of.gray2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  title,
                  style: AppTextStyle.headline2,
                ),
                const Gap(36),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      date,
                      style:
                          AppTextStyle.body2.copyWith(color: AppColor.of.gray4),
                    ),
                    SvgPicture.asset(Assets.iconsMoreNoCircle),
                  ],
                ),
              ],
            ),
          ),
        ),
        const Gap(12),
      ],
    );
  }
}

///
/// 이력서 파일 업로드
///
class FileUploadCard extends ConsumerWidget with ResumeManageEvent {
  const FileUploadCard({super.key, required this.type});

  final DocumentType type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Gap(12),
        Text(
          type == DocumentType.resume ? '이력서' : '포트폴리오',
          style: AppTextStyle.headline2,
        ),
        const Gap(8),
        BounceTapper(
          highlightColor: Colors.transparent,
          onTap: () => registDocument(ref, type),
          child: DottedBorder(
            color: AppColor.of.gray2,
            dashPattern: const [6, 1],
            borderType: BorderType.RRect,
            radius: const Radius.circular(12),
            child: Container(
              width: double.infinity,
              height: 163,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: Colors.transparent,
                    width: 112,
                    child: SvgPicture.asset(
                      Assets.iconsRoundBlueCircle,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Text(
                    "파일 업로드",
                    style:
                        AppTextStyle.body2.copyWith(color: AppColor.of.gray3),
                  ),
                ],
              ),
            ),
          ),
        ),
        const Gap(12),
      ],
    );
  }
}
