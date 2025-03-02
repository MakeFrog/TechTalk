import 'dart:convert';
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
import 'package:techtalk/features/chat/use_cases/create_gemini_resume_question_use_case.dart';
import 'package:techtalk/features/user/repositories/entities/portfolio_entity.dart';
import 'package:techtalk/features/user/repositories/entities/resume_entity.dart';
import 'package:techtalk/features/user/repositories/enums/document_type.enum.dart';
import 'package:techtalk/features/user/repositories/enums/resume_setting_type.enum.dart';
import 'package:techtalk/presentation/pages/resume/providers/resume_info_provider.dart';
import 'package:techtalk/presentation/pages/resume/resume_manage_page.dart';
import 'package:techtalk/presentation/widgets/common/dialog/app_dialog.dart';
import 'package:path/path.dart' as p;

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

    // 만약 이력이 필요 없다면, 사실상 로직 스킵 가능
    // (이미 registDocumentBtn에서 Documents 디렉토리에 복사했음)

    await ref.read(resumeInfoProvider.notifier).saveCurrentDocumentState();
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
    // 이력서 파일 자체가 없는 경우
    final doc = ref.read(resumeInfoProvider).requireValue;
    if ((doc?.resume?.path?.isEmpty ?? true) &&
        (doc?.portfolio?.path?.isEmpty ?? true)) {
      debugPrint('[에러] 이력서 및 포트폴리오 파일이 없습니다. 인터뷰를 진행할 수 없습니다.');
      return; // 조기 종료
    }

    // 로딩 중 페이지로 먼저 이동
    routeToResumeInterviewLoadingPage(ref);

    // PDF 저장
    await saveDocuments(ref);

    final DateTime startTime = DateTime.now();

    // 질문 생성 유즈케이스 실행
    final router = GoRouter.of(ref.context);
    final useCase = CreateResumeQuestionUseCase();
    final param = (
      resumePath: doc?.resume?.path ?? '',
      portfolioPath: doc?.portfolio?.path ?? ''
    );

    try {
      final result = await useCase.call(param as GetResumeParam);

      result.fold(
        onSuccess: (qnaList) {
          // 생성 가능한 질문 개수가 적은 경우 - 3개 미만
          if (qnaList.length < 3) {
            debugPrint('[에러] 생성 가능한 질문의 수가 너무 적습니다. (현재: ${qnaList.length}개)');
            return;
          }

          debugPrint("Gemini AI 질문 생성 성공, 총 ${qnaList.length}개");
          final mapped = qnaList
              .map(
                (q) => {
                  "id": q.id,
                  "question": q.question,
                  "type": q.questionType.name,
                  "evaluationPoint": q.evaluationPoint,
                },
              )
              .toList();
          final prettyJson = const JsonEncoder.withIndent('  ').convert(mapped);
          debugPrint("==== 면접 질문 결과 ====");
          debugPrint(prettyJson);

          // 채팅방 구성 후 이동
          final room = ChatRoomEntity.generateResumeInterview(qnas: qnaList);
          final route = ChatPageRoute(roomId: room.id, type: room.type);
          route.updateArg(room: room);
          router.go(route.location);
        },
        onFailure: (error) {
          debugPrint("[에러] AI 질문 생성 실패: $error");
        },
      );

      // 종료 시각 기록
      final DateTime endTime = DateTime.now();
      final duration = endTime.difference(startTime).inMilliseconds;
      debugPrint('===== 프롬프트 출력 시간: $duration ms =====');
    } catch (e, s) {
      debugPrint("[에러] AI 질문 생성 도중 예외 발생: $e");
      debugPrint("$s");
    }
  }

  /// 실제로 존재하는 파일 경로를 리턴하는 함수
  /// 1) [storedPath] 자체가 존재하는지 확인
  /// 2) 없다면 basename만 떼어 앱 내부 Documents 폴더와 합쳐 확인
  /// 3) 둘 다 없으면 Exception
  Future<String> getValidPath(WidgetRef ref, String storedPath) async {
    final storedFile = File(storedPath);

    // 1) 기존 절대 경로 파일이 존재하면 그대로 사용
    if (storedFile.existsSync()) {
      return storedPath;
    }

    // 2) 앱 내부 Documents 디렉토리를 구해 basename과 결합
    final docDir = await getApplicationDocumentsDirectory();
    final fileName = p.basename(storedPath); // 예) "myResume.pdf"
    final fallbackPath = p.join(docDir.path, fileName);
    final fallbackFile = File(fallbackPath);

    if (fallbackFile.existsSync()) {
      // Fallback 경로에 파일이 있으면 이걸 사용
      return fallbackPath;
    }

    // 3) 둘 다 없으면 예외
    throw Exception('파일을 찾을 수 없습니다.');
  }
}
