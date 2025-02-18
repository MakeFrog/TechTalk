import 'dart:developer';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
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
          if (type == DocumentType.resume) {
            resumeInfo.updateResumeState(ResumeEntity());
          } else {
            resumeInfo.updatePortfolioState(PortfolioEntity());
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
        String fileTitle = result.files.single.name;
        String filePath = '${tempDocDir.path}/$fileTitle';
        await File(tempDocPath).copy(filePath);
        String fileUploadAt = DateFormat('yyyy.MM.dd').format(DateTime.now());

        /// 상태 업데이트
        if (type == DocumentType.resume) {
          await resumeInfo.updateResumeState(
            ResumeEntity(
              path: filePath,
              title: fileTitle,
              uploadAt: fileUploadAt,
            ),
          );
        } else {
          await resumeInfo.updatePortfolioState(
            PortfolioEntity(
              path: filePath,
              title: fileTitle,
              uploadAt: fileUploadAt,
            ),
          );
        }
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
  /// 저장하기 버튼 클릭시
  ///
  Future<void> onClickedSaveBtn(WidgetRef ref) async {
    // 1) 현재 state를 가져온다.
    final resumeInfo = ref.read(resumeInfoProvider.notifier);

    final currentResume = ref.read(resumeInfoProvider).requireValue!.resume;
    final currentPortfolio =
        ref.read(resumeInfoProvider).requireValue!.portfolio;

    await resumeInfo.updateResumeData(currentResume);
    await resumeInfo.updatePortfolioData(currentPortfolio);

    debugPrint('저장이 완료되었습니다');
  }

  ///
  /// 미리보기 버튼 클릭시
  /// TODO: 수정 필요 (yundal)
  ///
  void onClickedPreviewBtn(WidgetRef ref, DocumentType type) {
    final state = ref.read(resumeInfoProvider);

    // 미리보기용 pdf 경로
    late final String? previewPath;

    // if (type == DocumentType.resume) {
    //   previewPath = state.resume.path;
    // } else {
    //   previewPath = state.portfolio.path;
    // }

    // if (previewPath == null) {
    //   debugPrint('PDF 경로가 존재하지 않습니다.');
    //   return;
    // }

    // ref.read(resumeInfoProvider.notifier).state = previewPath;

    const ResumePreviewRoute().push(ref.context);
  }
}
