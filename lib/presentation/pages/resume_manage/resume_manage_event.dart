import 'dart:developer';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:read_pdf_text/read_pdf_text.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/chat/repositories/entities/chat_room_entity.dart';
import 'package:techtalk/features/chat/repositories/entities/resume_qna_entity.dart';
import 'package:techtalk/features/chat/use_cases/create_resume_question_use_case.dart';
import 'package:techtalk/features/user/repositories/entities/portfolio_entity.dart';
import 'package:techtalk/features/user/repositories/entities/resume_entity.dart';
import 'package:techtalk/features/user/repositories/enums/document_type.enum.dart';
import 'package:techtalk/features/user/repositories/enums/resume_setting_type.enum.dart';
import 'package:techtalk/presentation/pages/resume_manage/providers/resume_info_provider.dart';
import 'package:techtalk/presentation/pages/resume_manage/resume_manage_page.dart';
import 'package:techtalk/presentation/widgets/common/dialog/app_dialog.dart';

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
        return ResumeManageBottomSheet(
          leadingText: '이력서',
          onCloseBtnTapped: context.pop,
          options: ResumeSettingType.values
              .map((e) => context.tr(e.nameTrKey))
              .toList(),
          onOptionTapped: (int index) {
            ResumeSettingType.branch(
              targetCategory: ResumeSettingType.getByIndex(index),
              upload: (_) => registDocumentBtn(ref, type),
              preview: (_) => onClickedPreviewBtn(ref, type),
              delete: (_) => onClickedDeleteBtn(ref, type),
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
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result == null) {
        return;
      }

      final pickedFile = File(result.files.single.path!);

      // 용량 초과 유무 확인
      if (pickedFile.lengthSync() >= maxFileSizeInBytes) {
        exceedCapacityDialog(ref);
      } else {
        final resumeInfo = ref.read(resumeInfoProvider.notifier);

        Directory tempDocDir = await getTemporaryDirectory();
        String tempDocPath = result.files.single.path!;
        String fileTitle = result.files.single.name
            .replaceAll(RegExp(r'\.pdf$', caseSensitive: false), '');
        String filePath = '${tempDocDir.path}/$fileTitle';
        await File(tempDocPath).copy(filePath);
        String fileUploadAt = DateFormat('yyyy.MM.dd').format(DateTime.now());

        /// 상태 업데이트
        if (type == DocumentType.resume) {
          final resume = ResumeEntity(
            path: filePath,
            title: fileTitle,
            uploadAt: fileUploadAt,
          );

          await resumeInfo.updateDocumentState(type, resume);
        } else {
          final portfolio = PortfolioEntity(
            path: filePath,
            title: fileTitle,
            uploadAt: fileUploadAt,
          );

          await resumeInfo.updateDocumentState(type, portfolio);
        }

        await resumeInfo.showTooltip();
      }
    } catch (e) {
      debugPrint('Error: $e');
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
  /// 이력서 등록 페이지로 이동
  ///
  void routeToResumeUploadPage(WidgetRef ref) {
    const ResumeUploadRoute().push(ref.context);
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
  /// UseCase 질문 뽑아내기
  ///
  Future<void> testSetAiResumeQuestionUseCase(
    String resumeContent,
    String portfolioContent,
  ) async {
    // 시작 시간 기록
    final DateTime startTime = DateTime.now();

    final useCase = CreateResumeQuestionUseCase();

    // 입력 파라미터 생성
    final param =
        (resumeContent: resumeContent, portfolioContent: portfolioContent);

    debugPrint('===== GPT에 응답을 요청했습니다 잠시만 기다려주세요 =====');

    try {
      final result = await useCase.call(param);
      result.fold(
        onSuccess: (qnaEntities) {
          debugPrint("AI 분석 성공");
        },
        onFailure: (error) {
          debugPrint("AI 분석 실패: $error");
        },
      );
    } catch (e) {
      log("UseCase 실행 중 예외 발생: $e");
    }

    // 종료 시간 기록
    final DateTime endTime = DateTime.now();

    // 시간 차이를 계산
    final duration = endTime.difference(startTime).inMilliseconds;

    // 실행 시간 출력
    debugPrint('===== 프롬프트 출력 시간: ${duration}ms =====');
  }

  ///
  /// PDF to TXT
  ///
  Future<String> extractPdfToTxt(String filePath) async {
    final localFilePath = await ReadPdfText.getPDFtext(filePath);

    if (localFilePath.isEmpty) {
      debugPrint('===========================');
      debugPrint('localResumePath의 경로가 비어있습니다');
      debugPrint('===========================');
      return '';
    }

    debugPrint('===========================');
    debugPrint('추출된 텍스트 : $localFilePath');
    debugPrint('===========================');

    return localFilePath;
  }

  ///
  /// 이력서 프롬프팅 뽑아내기
  ///
  Future<void> startResumeInterview(WidgetRef ref) async {
    // TODO: Gemini로 업로드하는 로직도 구현해보기 (yundal)

    // 완료시 다음 페이지 이동
    routeToResumeChatList(ref);
  }

  ///
  /// TODO: 250301 작업중 (윤수)
  /// 저장하기 버튼 클릭시
  ///
Future<void> onClickedSaveBtn(WidgetRef ref) async {
  await EasyLoading.show();

  // 1. 현재 문서 Entity 조회
  final state = ref.read(resumeInfoProvider);
  final doc = state.requireValue; 
  if (doc == null) {
    debugPrint('문서 정보가 존재하지 않습니다.');
    await EasyLoading.dismiss();
    return;
  }

  // 2. 디렉토리 준비 (임시 디렉토리, 영구 디렉토리)
  final Directory tempDir = await getTemporaryDirectory();
  final Directory permanentDir = await getApplicationDocumentsDirectory();

  // 이력서, 포트폴리오 임시 참조
  final tempResume = doc.resume;
  final tempPortfolio = doc.portfolio;

  // 3. 이력서 임시 경로 → 영구 경로 복사
  if (tempResume != null && tempResume.path != null) {
    // 임시 디렉토리에 있는지 확인
    if (tempResume.path!.startsWith(tempDir.path)) {
      final String? fileName = tempResume.title; // 확장자 없는 파일명
      final String newResumePath = '${permanentDir.path}/$fileName.pdf';

      try {
        // (1) 파일 복사
        await File(tempResume.path!).copy(newResumePath);
        // (2) 임시 파일 삭제
        await File(tempResume.path!).delete();

        // (3) 새로운 ResumeEntity 생성
        final updatedResume = ResumeEntity(
          path: newResumePath,
          title: tempResume.title,
          uploadAt: tempResume.uploadAt,
        );

        // (4) resumeInfoProvider의 상태 업데이트
        await ref
            .read(resumeInfoProvider.notifier)
            .updateDocumentState(DocumentType.resume, updatedResume);
      } catch (e) {
        debugPrint('이력서 영구 경로 이동 실패: $e');
      }
    }
  }

  // 4. 포트폴리오 임시 경로 → 영구 경로 복사
  if (tempPortfolio != null && tempPortfolio.path != null) {
    if (tempPortfolio.path!.startsWith(tempDir.path)) {
      final String? fileName = tempPortfolio.title;
      final String newPortfolioPath = '${permanentDir.path}/$fileName.pdf';

      try {
        await File(tempPortfolio.path!).copy(newPortfolioPath);
        await File(tempPortfolio.path!).delete();

        final updatedPortfolio = PortfolioEntity(
          path: newPortfolioPath,
          title: tempPortfolio.title,
          uploadAt: tempPortfolio.uploadAt,
        );

        await ref
            .read(resumeInfoProvider.notifier)
            .updateDocumentState(DocumentType.portfolio, updatedPortfolio);
      } catch (e) {
        debugPrint('포트폴리오 영구 경로 이동 실패: $e');
      }
    }
  }

  // 5. 최종 저장 로직 호출 (내부적으로 서버/로컬 DB에 반영)
  await ref.read(resumeInfoProvider.notifier).saveCurrentDocumentState();

  // 6. UI 처리 (화면 닫기, 로딩 종료 등)
  ref.context.pop();
  SnackBarService.showSnackBar('저장이 완료되었습니다.');
  debugPrint('저장이 완료되었습니다');
  await EasyLoading.dismiss();
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

    // TODO: UI로 알림 띄우는 로직 구현하기 (yundal)
    if (previewPath == null) {
      debugPrint('PDF 경로가 올바르지 않습니다.');
      return;
    }

    ResumePreviewRoute(previewPath: previewPath).push(ref.context);
  }
}
