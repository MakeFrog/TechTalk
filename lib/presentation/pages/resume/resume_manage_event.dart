import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
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
import 'package:techtalk/features/user/repositories/entities/document_entity.dart';
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

      // 파일명 설정
      final fileTitle = result.files.single.name
          .replaceAll(RegExp(r'\.pdf$', caseSensitive: false), '');
      final safeFileTitle = fileTitle.replaceAll(RegExp(r'[^\w\d_\-\.]+'), '_');
      final fileUploadAt = DateFormat('yyyy.MM.dd').format(DateTime.now());
      final Directory appDocDir = await getApplicationDocumentsDirectory();
      final targetPath = '${appDocDir.path}/$safeFileTitle.pdf';
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
        subTitle: '25MB보다 큰 파일은 등록할 수 없어요',
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
  void _routeToResumeInterviewLoadingPage(WidgetRef ref) {
    const ResumeInterviewLoadingRoute().push(ref.context);
  }

  ///
  /// 이력서 인터뷰 임시 코드
  /// TODO: XIMYA
  ///
  void routeToResumeChatList(WidgetRef ref, List<ResumeQnaEntity> qnaList) {
    final room = ChatRoomEntity.generateResumeInterview(qnas: qnaList);
    // tempResumeQnaList

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
    ref.invalidate(resumeInfoProvider);
    ref.context.pop();
    SnackBarService.showSnackBar('저장이 완료되었습니다.');
  }

  ///
  /// 로컬, 원격 문서 저장 로직
  ///
  Future<void> saveDocuments(WidgetRef ref) async {
    final stopwatch = Stopwatch()..start();
    debugPrint('PDF 문서 저장 시작');
    final state = ref.read(resumeInfoProvider);
    final doc = state.requireValue;
    if (doc == null) {
      debugPrint('문서가 없습니다');
      stopwatch.stop();
      debugPrint('PDF 문서 저장 소요 시간: ${stopwatch.elapsedMilliseconds} ms');
      return;
    }

    await ref.read(resumeInfoProvider.notifier).saveDocument();
    stopwatch.stop();
    debugPrint('PDF 문서 저장 소요 시간: ${stopwatch.elapsedMilliseconds} ms');
  }

  ///
  /// 면접 시작하기 버튼 클릭시
  ///
  Future<void> startResumeInterview(WidgetRef ref) async {
    await EasyLoading.show();
    final stopwatch = Stopwatch()..start();
    final doc = ref.read(resumeInfoProvider).requireValue;
    debugPrint('===== 면접 플로우 시작 =====');

    // 1) 문서 유효성 체크
    if (!_validateDocument(ref, doc)) {
      await EasyLoading.dismiss();
      return;
    }
    await EasyLoading.dismiss();

    try {
      // 2) 로딩 페이지로 이동
      _routeToResumeInterviewLoadingPage(ref);

      // 3) 면접 로직 진행 (문서 추출, 저장, 질문 생성 등)
      await _performInterviewFlow(ref, doc);
    } catch (e, s) {
      debugPrint('[에러] _performInterviewFlow 예외 발생: $e\n$s');
      ref.context.pop();
      SnackBarService.showSnackBar('면접 시작 중 오류가 발생했습니다. 잠시 후 다시 시도해주세요.');
    } finally {
      stopwatch.stop();
      debugPrint('면접 플로우 총 소요 시간: ${stopwatch.elapsedMilliseconds} ms');
    }
  }

  ///
  /// 문서 유효성 체크
  ///
  bool _validateDocument(WidgetRef ref, DocumentEntity? doc) {
    if (doc == null) {
      SnackBarService.showSnackBar('면접을 시작할 수 없습니다. 파일을 다시 등록해주세요.');
      return false;
    }
    final resumePath = doc.resume?.path ?? '';
    final portfolioPath = doc.portfolio?.path ?? '';
    if (resumePath.isEmpty && portfolioPath.isEmpty) {
      SnackBarService.showSnackBar('면접을 시작할 수 없습니다. 파일을 다시 등록해주세요.');
      return false;
    }
    return true;
  }

  ///
  /// 면접 로직 처리 (텍스트 추출 -> 문서 저장 + 질문 생성 -> 채팅방 이동)
  ///
  Future<void> _performInterviewFlow(WidgetRef ref, DocumentEntity? doc) async {
    final resumePath = doc?.resume?.path ?? '';
    final portfolioPath = doc?.portfolio?.path ?? '';

    // PDF 텍스트 추출
    final extractedText =
        await _validatePdfText(ref, resumePath, portfolioPath);
    if (extractedText == null) {
      return;
    }
    final (resumeText, portfolioText) = extractedText;

    // 문서 저장
    final docSaveFuture = saveDocuments(ref);

    // 질문 생성
    final qnaList =
        await _createQuestionsFromGemini(resumeText, portfolioText, ref);
    if (qnaList.isEmpty) {
      // 질문 생성 실패 → pop + snackBar 등
      ref.context.pop();
      return;
    }

    // 질문 생성 즉시 면접 화면으로 이동
    routeToResumeChatList(ref, qnaList);

    // 문서 저장 피드백 - 디버그 프린트로 실행
    await docSaveFuture.then((_) {
      debugPrint('문서 저장 완료 (면접 화면은 이미 보여지는 중)');
    }).catchError((err, st) {
      debugPrint('문서 저장 중 오류 발생: $err');
      // 오류 토스트 or retry 등
    });
  }

  ///
  /// 이력서 면접 질문 생성 로직
  ///
  Future<List<ResumeQnaEntity>> _createQuestionsFromGemini(
      String resumeText, String portfolioText, WidgetRef ref) async {
    final stopWatch = Stopwatch()..start();
    debugPrint('GEMINI 질문 생성 시작');

    final geminiQuestionUseCase = CreateGeminiResumeQuestionUseCase();

    final param = (resumeContent: resumeText, portfolioContent: portfolioText);
    final questionResult = await geminiQuestionUseCase.call(param);

    stopWatch.stop();
    debugPrint('GEMINI 질문 생성 소요시간: ${stopWatch.elapsedMilliseconds} ms');

    return questionResult.fold(
      onSuccess: (qnaList) => qnaList,
      onFailure: (error) {
        debugPrint('[에러] GEMINI 질문 생성 실패: $error');
        return <ResumeQnaEntity>[];
      },
    );
  }

  ///
  /// PDF 텍스트 추출 - 로컬, 원격으로 분기처리
  ///
  Future<String> _extractPdfText(String pdfPath) async {
    try {
      // 원격 파일인지 파악하기
      final bool isRemotePath = pdfPath.startsWith('http');
      Uint8List pdfBytes;

      // 원격 파일 분기처리
      if (isRemotePath) {
        final dio = Dio();
        final response = await dio.get<List<int>>(
          pdfPath,
          options: Options(responseType: ResponseType.bytes),
        );

        if (response.statusCode == 200 && response.data != null) {
          pdfBytes = Uint8List.fromList(response.data!);
        } else {
          debugPrint('PDF 다운로드 실패 - statusCode : ${response.statusCode}');
          return '';
        }
      }

      // 로컬 파일 분기처리
      else {
        pdfBytes = await File(pdfPath).readAsBytes();
      }

      // 텍스트 추출
      final document = PdfDocument(inputBytes: pdfBytes);
      final extractor = PdfTextExtractor(document);
      final extractedText = extractor.extractText();
      document.dispose();

      // 추출된 텍스트를 로그로 표시
      debugPrint('PDF 텍스트 추출 결과:\n$extractedText');

      return extractedText;
    } catch (e) {
      debugPrint('PDF 텍스트 추출 중 오류 발생: $e');
      return '';
    }
  }

  ///
  /// PDF에서 추출된 텍스트가 이력서 면접 질문 생성에 적합한지 검증
  ///
  Future<(String resumeText, String portfolioText)?> _validatePdfText(
      WidgetRef ref, String resumePath, String portfolioPath) async {
    final stopwatch = Stopwatch()..start();
    debugPrint('=== PDF 텍스트 추출 시작 ===');

    final resumeText = await _extractPdfText(resumePath);
    debugPrint('이력서 경로 : $resumePath');
    final portfolioText = await _extractPdfText(portfolioPath);
    debugPrint('포트폴리오 경로 : $portfolioPath');

    // 전체 길이 합산
    final totalTextLength =
        resumeText.trim().length + portfolioText.trim().length;

    // 200자 미만 시 예외 처리
    if (totalTextLength < 300) {
      debugPrint('텍스트가 총 $totalTextLength자로 300자 미만입니다.');
      ref.context.pop();
      SnackBarService.showSnackBar('추출된 텍스트가 너무 적습니다. 300자 이상으로 적어주세요.');
      return null;
    }

    stopwatch.stop();
    debugPrint('PDF 텍스트 추출 소요시간: ${stopwatch.elapsedMilliseconds} ms');
    // debugPrint('이력서 텍스트:\n$resumeText');
    // debugPrint('포트폴리오 텍스트:\n$portfolioText');

    return (resumeText, portfolioText);
  }
}

// TODO : OPEN AI 질문 생성 로직 (yundal)
// 텍스트 추출이 완료되었다는 전제하에 OpenAI를 통해 이력서 면접 질문 추출
// final gptStopwatch = Stopwatch()..start();
// final questionUseCase = CreateOpenAIResumeQuestionUseCase();
// final getResumeParam =
//     (resumeContent: resumePdfText, portfolioContent: portfolioPdfText);
// final questionResult = await questionUseCase.call(getResumeParam);
// gptStopwatch.stop();
// debugPrint('GPT 질문 생성 소요시간: ${gptStopwatch.elapsedMilliseconds} ms');

// questionResult.fold(
//   onSuccess: (qnaList) {
//     final room = ChatRoomEntity.generateResumeInterview(qnas: qnaList);
//     final route = ChatPageRoute(roomId: room.id, type: room.type);
//     route.updateArg(room: room);
//     GoRouter.of(ref.context).go(route.location);
//   },
//   onFailure: (error) {
//     debugPrint('[에러] GEMINI 질문 생성 실패: $error');
//     SnackBarService.showSnackBar('질문 생성에 실패했습니다. 잠시 후 다시 시도해 주세요.');
//   },
// );
