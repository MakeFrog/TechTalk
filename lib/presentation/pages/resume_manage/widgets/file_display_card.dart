part of 'package:techtalk/presentation/pages/resume_manage/resume_manage_page.dart';

///
/// 실제 파일(이력서/포트폴리오)을 보여주거나, 없으면 업로드 레이아웃을 표시하는 카드 위젯
///
class FileDisplayCard extends StatelessWidget {
  const FileDisplayCard({
    Key? key,
    required this.isResume,
    required this.localPath,
    required this.localTitle,
    required this.localDate,
    required this.tempPath,
    required this.tempTitle,
    required this.tempDate,
    required this.onFileTap,
    required this.onEmptyTap,
  }) : super(key: key);

  final bool isResume;
  final String localPath;
  final String localTitle;
  final String localDate;

  final String? tempPath;
  final String? tempTitle;
  final String? tempDate;

  final VoidCallback onFileTap;
  final VoidCallback onEmptyTap;

  @override
  Widget build(BuildContext context) {
    // 예외 로직: tempPath가 존재하면 temp 값을 우선
    final currentPath = tempPath ?? localPath;
    final currentTitle = tempPath != null ? tempTitle : localTitle;
    final currentDate = tempPath != null ? tempDate : localDate;

    // 파일이 없으면 업로드 컴포넌트
    if (currentPath.isEmpty) {
      return FileUploadPlaceholder(onTap: onEmptyTap);
    }

    // 파일이 존재하면 해당 파일 정보 표시
    return BounceTapper(
      highlightColor: Colors.transparent,
      onTap: onFileTap,
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
              currentTitle ?? '',
              style: AppTextStyle.headline2,
            ),
            const Gap(36),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  currentDate ?? '',
                  style: AppTextStyle.body2.copyWith(color: AppColor.of.gray4),
                ),
                SvgPicture.asset(Assets.iconsMoreNoCircle),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

///
/// dotted border가 들어간 파일 업로드 placeholder
///
class FileUploadPlaceholder extends StatelessWidget {
  const FileUploadPlaceholder({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return BounceTapper(
      highlightColor: Colors.transparent,
      onTap: onTap,
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
                style: AppTextStyle.body2.copyWith(color: AppColor.of.gray3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
