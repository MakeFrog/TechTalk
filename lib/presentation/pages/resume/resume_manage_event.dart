import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/chat/repositories/entities/chat_room_entity.dart';
import 'package:techtalk/features/chat/repositories/entities/resume_qna_entity.dart';
import 'package:techtalk/features/chat/repositories/enums/interview_type.enum.dart';
import 'package:techtalk/features/chat/use_cases/create_gemini_resume_question_use_case.dart';
import 'package:techtalk/features/user/repositories/entities/portfolio_entity.dart';
import 'package:techtalk/features/user/repositories/entities/resume_entity.dart';
import 'package:techtalk/features/user/repositories/enums/document_type.enum.dart';
import 'package:techtalk/features/user/repositories/enums/resume_setting_type.enum.dart';
import 'package:techtalk/presentation/pages/resume/providers/resume_info_provider.dart';
import 'package:techtalk/presentation/widgets/common/bottom_sheet/option_list_bottom_sheet.dart';
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
          switch (type) {
            case DocumentType.resume:
              resumeInfo.updateResumeState(null);
              break;

            case DocumentType.portfolio:
              resumeInfo.updatePortfolioState(null);
              break;
          }
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
    const maxFileSizeInBytes = 25 * 1024 * 1024; // 25MB

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
      final resumeInfoNotifier = ref.read(resumeInfoProvider.notifier);

      switch (type) {
        case DocumentType.resume:
          final resume = ResumeEntity(
            path: localCopied.path,
            title: fileTitle,
            uploadAt: fileUploadAt,
          );

          await resumeInfoNotifier.updateResumeState(resume);
          break;

        case DocumentType.portfolio:
          final portfolio = PortfolioEntity(
            path: localCopied.path,
            title: fileTitle,
            uploadAt: fileUploadAt,
          );
          await resumeInfoNotifier.updatePortfolioState(portfolio);
          break;
      }

      ref.read(resumeInfoProvider.notifier).showTooltip();
    } catch (e, s) {
      debugPrint('파일 등록 중 오류 발생: $e\n$s');
      SnackBarService.showSnackBar('파일 등록에 실패하였습니다. 다시 시도해주세요.');
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
        onRightBtnClicked: () => ref.context.pop(),
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
    if (doc == null) return;

    await ref.read(resumeInfoProvider.notifier).saveDocument();
    ref.invalidate(resumeInfoProvider);
  }

  ///
  /// 미리보기 버튼 클릭시
  ///
  void onClickedPreviewBtn(WidgetRef ref, DocumentType type) {
    final state = ref.read(resumeInfoProvider);
    late String? previewPath;

    switch (type) {
      case DocumentType.resume:
        previewPath = state.requireValue?.resume?.path;
        break;

      case DocumentType.portfolio:
        previewPath = state.requireValue?.portfolio?.path;
        break;
    }

    if (previewPath == null) {
      SnackBarService.showSnackBar('PDF 경로가 올바르지 않습니다. 파일을 다시 등록해주세요.');
      return;
    }

    ResumePreviewRoute(previewPath: previewPath).push(ref.context);
  }

  ///
  /// [pdfPath]에 있는 PDF 파일을 텍스트로 추출하여 반환
  ///
  Future<String> readPdfText(String pdfPath) async {
    try {
      final fileBytes = await File(pdfPath).readAsBytes();
      final document = PdfDocument(inputBytes: fileBytes);
      final extractor = PdfTextExtractor(document);

      // 텍스트 추출
      final extractedText = extractor.extractText();

      document.dispose();

      return extractedText;
    } catch (e) {
      debugPrint('PDF 파일에서 텍스트를 추출하는 중 오류 발생: $e');
      return '';
    }
  }

  ///
  /// 이력서 면접 시작 (프롬프팅)
  ///
  Future<void> startResumeInterview(WidgetRef ref) async {
    final totalStopwatch = Stopwatch()..start();
    final doc = ref.read(resumeInfoProvider).requireValue;
    if (doc == null) {
      SnackBarService.showSnackBar('면접을 시작할 수 없습니다. 이력서 정보를 확인해주세요.');
      return;
    }

    final resumePath = doc.resume?.path ?? '';
    final portfolioPath = doc.portfolio?.path ?? '';

    if (resumePath.isEmpty && portfolioPath.isEmpty) {
      SnackBarService.showSnackBar('이력서와 포트폴리오가 모두 등록되지 않았습니다.');
      return;
    }

    // 로딩 페이지로 이동 (분석중)
    routeToResumeInterviewLoadingPage(ref);

    try {
      // 문서 저장
      await saveDocuments(ref);

      // PDF 텍스트 추출
      final stopwatch = Stopwatch()..start();
      String resumePdfText = await readPdfText(resumePath);
      String portfolioPdfText = await readPdfText(portfolioPath);
      debugPrint('추출한 이력서 텍스트:\n$resumePdfText');
      debugPrint('추출한 포트폴리오 텍스트:\n$portfolioPdfText');
      stopwatch.stop();
      debugPrint('PDF 텍스트 추출 소요시간: ${stopwatch.elapsedMilliseconds} ms');

      // GEMINI로 질문 추출
      final aiStopWatch = Stopwatch()..start();
      final geminiQuestionUseCase = CreateGeminiResumeQuestionUseCase();

      final getGeminiParam =
          (resumeContent: resumePdfText, portfolioContent: portfolioPdfText);

      final questionResult = await geminiQuestionUseCase.call(getGeminiParam);
      aiStopWatch.stop();
      debugPrint('GEMINI 질문 생성 소요시간: ${aiStopWatch.elapsedMilliseconds} ms');

      // 텍스트가 모두 비어있을 경우에는 PDF가 Image로 랩핑되어있을 가능성이 있음
      // OCR 예외처리 - Gemini에서는 pdf의 이미지 텍스트 추출도 가능한 점을 이용함
      // TODO : 다음 커밋에 프롬프트 새로 적용할 예정 (yundal)
      // if (resumePdfText.isEmpty && portfolioPdfText.isEmpty) {
      //   debugPrint('OCR이 필요하여 Gemini 실행');
      //   final geminiStopwatch = Stopwatch()..start();
      //   final summarizeUseCase = SummarizeGeminiResumeUseCase();
      //   final getGeminiParam =
      //       (resumePath: resumePath, portfolioPath: portfolioPath);

      //   final geminiResult = await summarizeUseCase.call(getGeminiParam);
      //   geminiStopwatch.stop();
      //   debugPrint('Gemini 소요시간: ${geminiStopwatch.elapsedMilliseconds} ms');

      //   await geminiResult.fold(
      //     onSuccess: (geminiArray) async {
      //       resumePdfText = geminiArray[0]["content"] ?? '';
      //       portfolioPdfText = geminiArray[1]["content"] ?? '';

      //       // OCR 인식을 했음에도 빈값을 반환한 경우 예외처리 - 빈 문서를 첨부했을 확률이 높음
      //       if (resumePdfText.isEmpty && portfolioPdfText.isEmpty) {
      //         debugPrint('Gemini 결과도 비어있음. 면접 질문 생성을 중단합니다.');
      //         ref.context.pop();
      //         SnackBarService.showSnackBar('문서를 인식할 수 없습니다. 파일 상태를 확인해주세요.');
      //         return;
      //       }
      //     },
      //     onFailure: (error) {
      //       debugPrint('[에러] Gemini 요약 실패: $error');
      //       ref.context.pop(); // 뒤로 이동
      //       SnackBarService.showSnackBar('PDF 인식/요약에 실패했습니다. 잠시 후 다시 시도해주세요.');
      //       return;
      //     },
      //   );
      // }

      // TODO : OPEN AI 질문 생성 로직 (yundal)
      // 텍스트 추출이 완료되었다는 전제하에 OpenAI를 통해 이력서 면접 질문 추출
      // final gptStopwatch = Stopwatch()..start();
      // final questionUseCase = CreateOpenAIResumeQuestionUseCase();
      // final getResumeParam =
      //     (resumeContent: resumePdfText, portfolioContent: portfolioPdfText);
      // final questionResult = await questionUseCase.call(getResumeParam);
      // gptStopwatch.stop();
      // debugPrint('GPT 질문 생성 소요시간: ${gptStopwatch.elapsedMilliseconds} ms');

      questionResult.fold(
        onSuccess: (qnaList) {
          final room = ChatRoomEntity.generateResumeInterview(qnas: qnaList);
          final route = ChatPageRoute(roomId: room.id, type: room.type);
          route.updateArg(room: room);
          GoRouter.of(ref.context).go(route.location);
        },
        onFailure: (error) {
          debugPrint('[에러] GEMINI 질문 생성 실패: $error');
          SnackBarService.showSnackBar('질문 생성에 실패했습니다. 잠시 후 다시 시도해 주세요.');
        },
      );
    } catch (e, s) {
      debugPrint('[에러] startResumeInterview 예외 발생: $e\n$s');
      SnackBarService.showSnackBar('면접 시작 중 오류가 발생했습니다. 잠시 후 다시 시도해주세요.');
    } finally {
      totalStopwatch.stop();
      debugPrint('전체 소요시간: ${totalStopwatch.elapsedMilliseconds} ms');
    }
  }
}
