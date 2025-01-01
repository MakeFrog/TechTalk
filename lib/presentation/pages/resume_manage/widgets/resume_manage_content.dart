part of '../resume_manage_page.dart';

class _ResumeManageContent extends HookConsumerWidget with ResumeManageEvent {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// 주요 변수
    final resumePath = useState<String?>(null);
    final resumeTitle = useState<String?>(null);
    final resumeDate = useState<String?>(null);

    final portfolioPath = useState<String?>(null);
    final portfolioTitle = useState<String?>(null);
    final portfolioDate = useState<String?>(null);

    /// PDF 파일 선택 후 임시로 저장
    Future<void> pickAndSaveFile(isResume) async {
      try {
        // 파일 선택
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['pdf'],
        );

        if (result != null && result.files.single.path != null) {
          // 경로
          Directory tempDocDir = await getTemporaryDirectory();
          String filePath = result.files.single.path!;
          String fileName = result.files.single.name;
          String savedFilePath = '${tempDocDir.path}/$fileName';

          // 이름 및 날짜
          String tempFileTitle = fileName;
          String tempFileDate = DateFormat('yyyy.MM.dd').format(DateTime.now());

          // 파일 원본 저장
          await File(filePath).copy(savedFilePath);

          // 디버깅
          debugPrint('filePath : $filePath');
          debugPrint('fileName : $fileName');
          debugPrint('savedFilePath : $savedFilePath');

          // 이력서 또는 포트폴리오 데이터를 저장
          if (isResume) {
            resumePath.value = savedFilePath;
            resumeTitle.value = tempFileTitle;
            resumeDate.value = tempFileDate;
          } else {
            portfolioPath.value = savedFilePath;
            portfolioTitle.value = tempFileTitle;
            portfolioDate.value = tempFileDate;
          }
        } else {
          throw Exception('No file selected or invalid file path.');
        }
      } catch (e) {
        debugPrint('Error: $e');
      }
    }

    /// 이력서/포트폴리오 등록 위젯
    Widget buildAddFile(String title, isResume) {
      final filePath = isResume ? resumePath.value : portfolioPath.value;
      final fileTitle = isResume ? resumeTitle.value : portfolioTitle.value;
      final fileDate = isResume ? resumeDate.value : portfolioDate.value;

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(title, style: AppTextStyle.headline2),
            const Gap(8),
            if (filePath != null)
              BounceTapper(
                highlightColor: Colors.transparent,
                onTap: () => onRegisteredFileBtnTapped(ref),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColor.of.gray2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        fileTitle!,
                        style: AppTextStyle.headline2,
                      ),
                      const Gap(36),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            fileDate!,
                            style: AppTextStyle.body2
                                .copyWith(color: AppColor.of.gray4),
                          ),
                          SvgPicture.asset(Assets.iconsMoreNoCircle),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            else
              BounceTapper(
                highlightColor: Colors.transparent,
                onTap: () async => pickAndSaveFile(isResume),
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
                          style: AppTextStyle.body2
                              .copyWith(color: AppColor.of.gray3),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '50MB 이하의 PDF 파일만 등록할 수 있어요',
          style: AppTextStyle.body1.copyWith(color: AppColor.of.gray4),
        ),
        const Gap(12),
        buildAddFile('이력서', true),
        buildAddFile('포트폴리오', false),
      ],
    );
  }
}
