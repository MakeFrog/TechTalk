import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/chat/repositories/entities/chat_room_entity.dart';
import 'package:techtalk/features/chat/repositories/entities/resume_qna_entity.dart';
import 'package:techtalk/features/chat/repositories/enums/interview_type.enum.dart';
import 'package:techtalk/features/chat/use_cases/create_openai_resume_question_use_case.dart';
import 'package:techtalk/features/user/repositories/entities/portfolio_entity.dart';
import 'package:techtalk/features/user/repositories/entities/resume_entity.dart';
import 'package:techtalk/features/user/repositories/enums/document_type.enum.dart';
import 'package:techtalk/features/user/repositories/enums/resume_setting_type.enum.dart';
import 'package:techtalk/presentation/pages/resume/providers/resume_info_provider.dart';
import 'package:techtalk/presentation/widgets/common/bottom_sheet/option_list_bottom_sheet.dart';
import 'package:techtalk/presentation/widgets/common/dialog/app_dialog.dart';
import '../../../features/chat/use_cases/summarize_gemini_resume_use_case.dart';

mixin class ResumeManageEvent {
  ///
  /// 설정 bottom sheet 모달창 노출
  ///
  void onRegisteredFileBtnTapped(
    WidgetRef ref,
    DocumentType type,
  ) {
    showModalBottomSheet(
      context: ref.context,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return OptionListBottomSheet(
          leadingText: '이력서',
          onCloseBtnTapped: context.pop,
          highlightedIndexes: const {2}, // 강조하고싶은 버튼의 인덱스
          options: ResumeSettingType.values
              .map((e) => context.tr(e.nameTrKey))
              .toList(),
          onOptionTapped: (int index) {
            ResumeSettingType.branch(
              targetCategory: ResumeSettingType.getByIndex(index),
              upload: (_) {
                context.pop();
                registDocumentBtn(ref, type);
              },
              preview: (_) {
                context.pop();
                onClickedPreviewBtn(ref, type);
              },
              delete: (_) {
                context.pop();
                onClickedDeleteBtn(ref, type);
              },
            );
          },
        );
      },
    );
  }

  ///
  /// 삭제 버튼 클릭시
  ///
  void onClickedDeleteBtn(WidgetRef ref, DocumentType type) {
    final resumeInfo = ref.read(resumeInfoProvider.notifier);

    DialogService.show(
      dialog: AppDialog.dividedBtn(
        title: '삭제',
        description: '삭제하시겠습니까?',
        leftBtnContent: '취소',
        rightBtnContent: '삭제',
        onRightBtnClicked: () {
          resumeInfo.updateDocumentState(type, null);
          ref.context.pop();
        },
        onLeftBtnClicked: () => ref.context.pop(),
        showContentImg: false,
      ),
    );
  }

  ///
  /// 이력서, 포폴 문서 등록
  ///
  Future<void> registDocumentBtn(WidgetRef ref, DocumentType type) async {
    const maxFileSizeInBytes = 50 * 1024 * 1024; // 50MB

    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      if (result == null || result.files.isEmpty) return;

      final pickedPath = result.files.single.path;
      if (pickedPath == null) return;

      final pickedFile = File(pickedPath);

      // 용량 초과 체크
      if (pickedFile.lengthSync() > maxFileSizeInBytes) {
        exceedCapacityDialog(ref);
        return;
      }

      // 임시 파일명
      final fileTitle = result.files.single.name
          .replaceAll(RegExp(r'\.pdf$', caseSensitive: false), '');
      final fileUploadAt = DateFormat('yyyy.MM.dd').format(DateTime.now());

      // 앱 내부(또는 임시) 디렉토리로 복사
      final Directory appDocDir = await getApplicationDocumentsDirectory();
      final targetPath = '${appDocDir.path}/$fileTitle.pdf';
      final localCopied = await pickedFile.copy(targetPath);

      // Entity 생성
      final resumeInfoNotifier = ref.read(resumeInfoProvider.notifier);

      if (type == DocumentType.resume) {
        final resume = ResumeEntity(
          path: localCopied.path,
          title: fileTitle,
          uploadAt: fileUploadAt,
        );
        await resumeInfoNotifier.updateDocumentState(type, resume);
      } else {
        final portfolio = PortfolioEntity(
          path: localCopied.path,
          title: fileTitle,
          uploadAt: fileUploadAt,
        );
        await resumeInfoNotifier.updateDocumentState(type, portfolio);
      }

      // 추가적인 UI 표시
      await ref.read(resumeInfoProvider.notifier).showTooltip();
    } catch (e, s) {
      debugPrint('파일 등록 중 오류 발생: $e\n$s');
    }
  }

  ///
  /// 용량 초과 로직
  ///
  void exceedCapacityDialog(WidgetRef ref) {
    DialogService.show(
      dialog: AppDialog.dividedBtn(
        title: '용량이 초과됐어요',
        subTitle: '50MB보다 큰 파일은 등록할 수 없어요',
        leftBtnContent: '취소',
        rightBtnContent: '다시 올리기',
        showContentImg: true,
        onRightBtnClicked: () {
          ref.context.pop();
          // 이후 다시 파일 업로드하기
        },
        onLeftBtnClicked: ref.context.pop,
        customAssetPath: Assets.iconsPolygonWarning,
      ),
    );
  }

  ///
  /// 이력서 면접 - 업로드 페이지로 이동
  ///
  void routeToResumeUploadPage(WidgetRef ref) {
    const ResumeInterviewRoute(InterviewType.resume).push(ref.context);
  }

  ///
  /// 이력서 질문 프롬프팅 로딩 페이지로 이동
  ///
  void routeToResumeInterviewLoadingPage(WidgetRef ref) {
    const ResumeInterviewLoadingRoute().push(ref.context);
  }

  ///
  /// 이력서 인터뷰 임시 코드
  /// TODO: XIMYA
  ///
  void routeToResumeChatList(WidgetRef ref) {
    final room = ChatRoomEntity.generateResumeInterview(
      qnas: tempResumeQnaList,
    );

    final route = ChatPageRoute(roomId: room.id, type: room.type);
    route.updateArg(room: room);
    route.go(ref.context);
    return;
  }

  ///
  /// 저장하기 버튼 클릭시
  ///
  Future<void> onClickedSaveBtn(WidgetRef ref) async {
    await EasyLoading.show();
    await saveDocuments(ref);
    await EasyLoading.dismiss();
    ref.context.pop();
    SnackBarService.showSnackBar('저장이 완료되었습니다.');
  }

  ///
  /// 문서 저장하기
  ///
  Future<void> saveDocuments(WidgetRef ref) async {
    final state = ref.read(resumeInfoProvider);
    final doc = state.requireValue;
    if (doc == null) {
      debugPrint('문서 정보가 존재하지 않습니다.');
      return;
    }

    await ref.read(resumeInfoProvider.notifier).saveDocument();
    debugPrint('저장이 완료되었습니다');
  }

  ///
  /// 미리보기 버튼 클릭시
  ///
  void onClickedPreviewBtn(WidgetRef ref, DocumentType type) {
    final state = ref.read(resumeInfoProvider);

    // 미리보기용 pdf 경로
    late String? previewPath;

    if (type == DocumentType.resume) {
      previewPath = state.requireValue?.resume?.path;
    } else {
      previewPath = state.requireValue?.portfolio?.path;
    }

    if (previewPath == null) {
      debugPrint('PDF 경로가 올바르지 않습니다.');
      return;
    }

    ResumePreviewRoute(previewPath: previewPath).push(ref.context);
  }

  ///
  /// 이력서 면접 시작 (프롬프팅)
  ///
  Future<void> startResumeInterview(WidgetRef ref) async {
    final doc = ref.read(resumeInfoProvider).requireValue;
    if ((doc?.resume?.path?.isEmpty ?? true) &&
        (doc?.portfolio?.path?.isEmpty ?? true)) {
      debugPrint('[에러] 이력서 및 포트폴리오 파일이 없습니다. 인터뷰를 진행할 수 없습니다.');
      return;
    }

    // 로딩 화면
    routeToResumeInterviewLoadingPage(ref);

    // 이력서 관리 파일에 변화가 있을 때에만 PDF 저장 로직 실행
    // TODO: 이력서/포트폴리오중 하나만 변경시 변경된 것만 저장하도록 예외처리 (yundal)
    if (doc?.isFileChanged == true) {
      await saveDocuments(ref);
    }

    final router = GoRouter.of(ref.context);
    final summarizeUseCase = SummarizeGeminiResumeUseCase();

    final resumePath = doc?.resume?.path ?? '';
    final portfolioPath = doc?.portfolio?.path ?? '';

    debugPrint('startResumeInterview');
    debugPrint('resumePath : $resumePath');
    debugPrint('portfolioPath : $portfolioPath');

    // GEMINI로 요약하기
    final getGeminiParam =
        (resumePath: resumePath, portfolioPath: portfolioPath);

    final summarizeResult = await summarizeUseCase.call(getGeminiParam);

    await summarizeResult.fold(
      // 요약된 내용 기반으로 질문 생성하기
      onSuccess: (map) async {
        final resumeText = map[0]["content"];
        final portfolioText = map[1]["content"];

        final questionUseCase = CreateOpenAIResumeQuestionUseCase();
        final getResumeParam = (
          resumeContent: resumeText ?? '',
          portfolioContent: portfolioText ?? ''
        );

        final questionResult = await questionUseCase.call(getResumeParam);

        questionResult.fold(
          onSuccess: (qnaList) {
            // 질문 생성 성공 => 채팅방 이동
            final room = ChatRoomEntity.generateResumeInterview(qnas: qnaList);
            final route = ChatPageRoute(roomId: room.id, type: room.type);
            route.updateArg(room: room);
            router.go(route.location);
          },
          onFailure: (error) {
            debugPrint("[에러] 질문 생성 실패: $error");
          },
        );
      },
      onFailure: (error) {
        debugPrint("[에러] PDF 요약 실패: $error");
      },
    );
  }
}
