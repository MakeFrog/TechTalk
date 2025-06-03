import 'dart:async';
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
import 'package:techtalk/app/util/app_logger.dart';
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

mixin class ResumeEvent {
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
                registDocumentState(ref, type);
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
  /// 이력서, 포폴 문서 상태 등록
  /// [FileUploadCard] 혹은 [onRegisteredFileBtnTapped]에서 수행됨
  /// 파일을 저장하는 로직은 아님. 저장하기 버튼을 눌러야 상태가 파일로 저장됨
  ///
  Future<void> registDocumentState(WidgetRef ref, DocumentType type) async {
    const int textMinLength = 300;
    const int maxFileSizeInBytes = 25 * 1024 * 1024; // 25MB

    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      if (result == null || result.files.isEmpty) return;

      await EasyLoading.show(status: '문서의 텍스트를 추출중입니다');

      final pickedPath = result.files.single.path;
      if (pickedPath == null) return;

      final pickedFile = File(pickedPath);

      /// =============== 예외처리 ===============
      // 1) 용량 초과 체크
      if (pickedFile.lengthSync() > maxFileSizeInBytes) {
        exceedCapacityDialog(ref);
        return;
      }

      // 2) 추출한 텍스트가 면접 질문 추출에 유의미한 길이인가? (300자 이상)
      final Uint8List pdfBytes = await pickedFile.readAsBytes();
      final document = PdfDocument(inputBytes: pdfBytes);
      final extractor = PdfTextExtractor(document);
      final extractedText = extractor.extractText();
      debugPrint('추출된 텍스트 : $extractedText');
      document.dispose();

      if (extractedText.length < textMinLength) {
        await EasyLoading.dismiss();
        showInsufficientTextDialog(ref);
        return;
      }

      /// =============== 예외처리 통과 ===============
      final resumeInfoNotifier = ref.read(resumeInfoProvider.notifier);
      final fileTitle = result.files.single.name
          .replaceAll(RegExp(r'\.pdf$', caseSensitive: false), '');
      final safeFileTitle = fileTitle.replaceAll(RegExp(r'[^\w\d_\-\.]+'), '_');
      final fileUploadAt = DateFormat('yyyy.MM.dd').format(DateTime.now());
      final Directory appDocDir = await getApplicationDocumentsDirectory();
      final targetPath = '${appDocDir.path}/$safeFileTitle.pdf';
      final localCopied = await pickedFile.copy(targetPath);

      switch (type) {
        case DocumentType.resume:
          final resume = ResumeEntity(
            path: localCopied.path,
            title: fileTitle,
            uploadAt: fileUploadAt,
            extractedText: extractedText,
          );

          await resumeInfoNotifier.updateResumeState(resume);
          break;

        case DocumentType.portfolio:
          final portfolio = PortfolioEntity(
            path: localCopied.path,
            title: fileTitle,
            uploadAt: fileUploadAt,
            extractedText: extractedText,
          );
          await resumeInfoNotifier.updatePortfolioState(portfolio);
          break;
      }
      ref.read(resumeInfoProvider.notifier).showTooltip();
    } catch (e, s) {
      debugPrint('파일 등록 중 오류 발생: $e\n$s');
      SnackBarService.showSnackBar('파일 등록에 실패하였습니다. 다시 시도해주세요.');
    } finally {
      await EasyLoading.dismiss();
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
  /// 텍스트 길이가 300자 미만일 때 문서 상태 등록 에러 안내
  ///
  void showInsufficientTextDialog(WidgetRef ref) {
    DialogService.show(
      dialog: AppDialog.dividedBtn(
        title: '추출된 텍스트가 너무 짧아요',
        subTitle: '면접 질문 생성을 위해서는\n300자 이상의 텍스트가 추출되어야 합니다',
        leftBtnContent: '취소',
        rightBtnContent: '다시 올리기',
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
    // 1) 백그라운드 저장 로직
    unawaited(
      saveDocuments(ref).then((_) {
        debugPrint('✅ 실제 문서 저장 완료');
      }).catchError((e, s) {
        debugPrint('❌ 실제 문서 저장 실패: $e');
      }),
    );

    // 2) 원격 저장은 너무 오래걸려서 페이크 딜레이 2초 주기
    await EasyLoading.show(status: '문서를 저장중입니다');
    await Future.delayed(const Duration(seconds: 2));
    await EasyLoading.dismiss();
    if (ref.context.mounted) {
      ref.invalidate(resumeInfoProvider);
      ref.context.pop();
      SnackBarService.showSnackBar('저장이 완료되었습니다.');
    }
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
    final nullableDoc = ref.read(resumeInfoProvider).requireValue;
    debugPrint('===== 면접 플로우 시작 =====');

    // 1) 문서 유효성 체크 - 혹시 모를 안전장치
    // doc이 null이거나 출력된 텍스트가 비어있는 경우
    if (!_validateDocument(ref, nullableDoc)) {
      await EasyLoading.dismiss();
      return;
    }
    final doc = nullableDoc!;
    await EasyLoading.dismiss();

    // 2) 로딩 페이지로 이동
    _routeToResumeInterviewLoadingPage(ref);

    try {
      // 3) 병렬처리 -> 면접 질문 생성하기 && 문서 파일 저장하기 로직
      // 문서 저장
      final docSaveFuture = saveDocuments(ref);

      // 질문 생성
      final qnaList = await _createQuestionsFromGemini(doc, ref);
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
      });
    } catch (e, s) {
      logger.e('에러 발생: $e\n$s');
      ref.context.pop();
      SnackBarService.showSnackBar('면접 시작 중 오류가 발생했습니다. 잠시 후 다시 시도해주세요.');
    } finally {
      stopwatch.stop();
      debugPrint('면접 플로우 총 소요 시간: ${stopwatch.elapsedMilliseconds} ms');
    }
  }

  ///
  /// 1) 문서 유효성 체크
  ///
  bool _validateDocument(WidgetRef ref, DocumentEntity? doc) {
    if (doc == null) {
      SnackBarService.showSnackBar('면접을 시작할 수 없습니다. 파일을 다시 등록해주세요.');
      return false;
    }
    final resumeText = doc.resume?.extractedText ?? '';
    final portfolioText = doc.portfolio?.extractedText ?? '';
    if (resumeText.isEmpty && portfolioText.isEmpty) {
      SnackBarService.showSnackBar('면접을 시작할 수 없습니다. 파일을 다시 등록해주세요.');
      return false;
    }
    return true;
  }

  ///
  /// 2) 이력서 질문 프롬프팅 로딩 페이지로 이동
  ///
  void _routeToResumeInterviewLoadingPage(WidgetRef ref) {
    const ResumeInterviewLoadingRoute().push(ref.context);
  }

  ///
  /// 3) 이력서 면접 질문 생성 로직
  ///
  Future<List<ResumeQnaEntity>> _createQuestionsFromGemini(
      DocumentEntity doc, WidgetRef ref) async {
    final stopWatch = Stopwatch()..start();
    debugPrint('GEMINI 질문 생성 시작');

    // 문서에서 추출된 텍스트
    final String resumeText = doc.resume?.extractedText ?? '';
    final String portfolioText = doc.portfolio?.extractedText ?? '';

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
}

// TODO : OPEN AI 질문 생성 로직 (yundal)
// 아직 GEMINI vs OPENAI 중 어떤 플랫폼으로 질문 추출할지 결정하지 않아서 임시로 주석 처리
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
