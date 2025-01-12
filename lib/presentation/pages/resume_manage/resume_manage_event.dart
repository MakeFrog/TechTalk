import 'dart:developer';
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
import 'package:techtalk/features/chat/use_cases/create_resume_question_use_case.dart';
import 'package:techtalk/presentation/pages/resume_manage/providers/resume_local_data_info_provider.dart';
import 'package:techtalk/presentation/pages/resume_manage/providers/resume_preview_path_provider.dart';
import 'package:techtalk/presentation/pages/resume_manage/providers/resume_temp_data_info_provider.dart';
import 'package:techtalk/presentation/pages/resume_manage/resume_manage_page.dart';
import 'package:techtalk/presentation/widgets/common/dialog/app_dialog.dart';

mixin class ResumeManageEvent {
  ///
  /// 설정 bottom sheet 모달창 노출
  ///
  void onRegisteredFileBtnTapped(
    WidgetRef ref, {
    required bool isResume,
    required bool isLocal,
  }) {
    showModalBottomSheet(
      context: ref.context,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return ResumeManageBottomSheet(
          onCloseBtnTapped: context.pop,
          onOptionTapped: (int index) {
            switch (index) {
              case 0: // 변경
                isResume
                    ? resumePickAndSaveFile(ref)
                    : portfolioPickAndSaveFile(ref);
                break;
              case 1: // 미리보기
                onClickedPreviewBtn(ref, isLocal: isLocal, isResume: isResume);
                break;
              case 2: // 삭제
                onClickedDeleteBtn(ref, isLocal: isLocal, isResume: isResume);
                break;
              default:
                break;
            }
          },
        );
      },
    );
  }

  ///
  /// 미리보기 버튼 클릭시
  ///
  void onClickedPreviewBtn(
    WidgetRef ref, {
    required bool isResume,
    required bool isLocal,
  }) {
    final tempState = ref.read(resumeTempDataInfoProvider);
    final localState = ref.read(resumeLocalDataInfoProvider);

    // 미리보기용 pdf 경로
    late final String? previewPath;

    if (isResume) {
      previewPath =
          isLocal ? localState.localResumePath : tempState.tempResumePath;
    } else {
      previewPath =
          isLocal ? localState.localPortfolioPath : tempState.tempPortfolioPath;
    }

    if (previewPath == null) {
      debugPrint('PDF 경로가 존재하지 않습니다.');
      return;
    }

    // -- (1) resumePreviewPathProvider 값 업데이트
    ref.read(resumePreviewPathProvider.notifier).state = previewPath;

    // -- (2) 페이지 이동 시에는 인자를 직접 넘기지 않고, provider로부터 읽도록 만듦
    const ResumePreviewRoute().push(ref.context);
  }

  ///
  /// 삭제 버튼 클릭시
  ///
  void onClickedDeleteBtn(
    WidgetRef ref, {
    required bool isResume,
    required bool isLocal,
  }) {
    ResumeTempState tempState = ref.read(resumeTempDataInfoProvider);
    final tempNotifier = ref.read(resumeTempDataInfoProvider.notifier);

    DialogService.show(
      dialog: AppDialog.dividedBtn(
        title: '삭제',
        description: '삭제하시겠습니까?',
        leftBtnContent: '취소',
        rightBtnContent: '삭제',
        onRightBtnClicked: () {
          if (isResume) {
            if (isLocal) {
              tempNotifier.setLocalResumeDeleted(value: true);
              tempNotifier.updateTempResume(null, null, null);
              tempState = ref.read(resumeTempDataInfoProvider);

              debugPrint(
                ' ===== 임시 이력서 경로 : ${tempState.tempResumePath} ===== ',
              );
              debugPrint(
                ' ===== 임시 이력서 제목 : ${tempState.tempResumeTitle} ===== ',
              );
              debugPrint(
                ' ===== 임시 이력서 날짜 : ${tempState.tempResumeDate} ===== ',
              );
              debugPrint(
                ' ===== 로컬 데이터 삭제 예정? : ${tempState.isLocalResumeDeleted} ===== ',
              );
            } else {
              tempNotifier.updateTempResume(null, null, null);
            }
          } else {
            if (isLocal) {
              tempNotifier.setLocalPortfolioDeleted(value: true);
              tempNotifier.updateTempPortfolio(null, null, null);
              tempState = ref.read(resumeTempDataInfoProvider);

              debugPrint(
                ' ===== 임시 포트폴리오 경로 : ${tempState.tempPortfolioPath} ===== ',
              );
              debugPrint(
                ' ===== 임시 포트폴리오 제목 : ${tempState.tempPortfolioTitle} ===== ',
              );
              debugPrint(
                ' ===== 임시 포트폴리오 날짜 : ${tempState.tempPortfolioDate} ===== ',
              );
              debugPrint(
                ' ===== 로컬 데이터 삭제 예정? : ${tempState.isLocalPortfolioDeleted} ===== ',
              );
            } else {
              tempNotifier.updateTempPortfolio(null, null, null);
            }
          }

          ref.context.pop();
        },
        onLeftBtnClicked: () => ref.context.pop(),
        showContentImg: false,
      ),
    );
  }

  ///
  /// 저장하기 버튼 클릭시
  ///
  Future<void> onClickedSaveBtn(WidgetRef ref) async {
    await EasyLoading.show();

    final tempState = ref.read(resumeTempDataInfoProvider);
    final tempNotifier = ref.read(resumeTempDataInfoProvider.notifier);
    final localNotifier = ref.read(resumeLocalDataInfoProvider.notifier);

    // 이력서 초기화 요청 존재한다면 먼저 실행
    if (tempState.isLocalResumeDeleted) {
      localNotifier.updateLocalResume(
        '',
        '',
        '',
      );
    }

    // 포트폴리오 초기화 요청 존재한다면 먼저 실행
    if (tempState.isLocalPortfolioDeleted) {
      localNotifier.updateLocalPortfolio(
        '',
        '',
        '',
      );
    }

    // 이력서 PDF 업데이트
    if (tempState.tempResumePath != null) {
      final appDocDir = await getApplicationDocumentsDirectory();
      final localResumePath = '${appDocDir.path}/${tempState.tempResumeTitle}';

      // 임시 경로 → 앱 문서 디렉토리로 복사
      await File(tempState.tempResumePath!).copy(localResumePath);

      // ResumeLocalDataInfoProvider 갱신
      localNotifier.updateLocalResume(
        localResumePath,
        tempState.tempResumeTitle ?? '',
        tempState.tempResumeDate ?? '',
      );

      // TODO : 이력서 업데이트 후 기존에 저장되어있던 파일을 삭제해야함(yundal)
    }

    // 2) 포트폴리오 PDF 업데이트
    if (tempState.tempPortfolioPath != null) {
      final appDocDir = await getApplicationDocumentsDirectory();
      final localPortfolioPath =
          '${appDocDir.path}/${tempState.tempPortfolioTitle}';

      // 임시 경로 → 앱 문서 디렉토리로 복사
      await File(tempState.tempPortfolioPath!).copy(localPortfolioPath);

      // ResumeLocalDataInfoProvider 갱신
      localNotifier.updateLocalPortfolio(
        localPortfolioPath,
        tempState.tempPortfolioTitle ?? '',
        tempState.tempPortfolioDate ?? '',
      );

      // TODO : 포트폴리오 업데이트 후 기존에 저장되어있던 파일을 삭제해야함(yundal)
    }

    // 3) Temp State 초기화
    tempNotifier.resetTempState();

    // 저장 완료 후
    await EasyLoading.dismiss();
    if (ref.context.mounted) {
      ref.context.pop();
    }
  }

  ///
  /// 이력서 파일 선택시
  ///
  Future<void> resumePickAndSaveFile(WidgetRef ref) async {
    const maxFileSizeInBytes = 50 * 1024 * 1024;

    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result == null) {
        return;
      }

      final pickedFile = File(result.files.single.path!);

      if (pickedFile.lengthSync() > maxFileSizeInBytes) {
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

      if (pickedFile.lengthSync() < maxFileSizeInBytes) {
        Directory tempDocDir = await getTemporaryDirectory();
        String filePath = result.files.single.path!;
        String tempResumeTitle = result.files.single.name;

        String tempResumePath = '${tempDocDir.path}/$tempResumeTitle';
        await File(filePath).copy(tempResumePath);

        String tempResumeDate = DateFormat('yyyy.MM.dd').format(DateTime.now());

        // 값 업데이트
        ResumeTempState tempState = ref.read(resumeTempDataInfoProvider);
        final notifier = ref.read(resumeTempDataInfoProvider.notifier);
        notifier.updateTempResume(
          tempResumePath,
          tempResumeTitle,
          tempResumeDate,
        );

        tempState = ref.read(resumeTempDataInfoProvider);

        debugPrint(
          ' ===== 임시 이력서 경로 : ${tempState.tempResumePath} ===== ',
        );
        debugPrint(
          ' ===== 임시 이력서 제목 : ${tempState.tempResumeTitle} ===== ',
        );
        debugPrint(
          ' ===== 임시 이력서 날짜 : ${tempState.tempResumeDate} ===== ',
        );
        debugPrint(
          ' ===== 로컬 데이터 삭제 예정? : ${tempState.isLocalResumeDeleted} ===== ',
        );
      } else {
        throw Exception('No file selected or invalid file path.');
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  ///
  /// 포트폴리오 파일 선택시
  ///
  Future<void> portfolioPickAndSaveFile(WidgetRef ref) async {
    const maxFileSizeInBytes = 50 * 1024 * 1024;

    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result == null) {
        return;
      }

      final pickedFile = File(result.files.single.path!);

      if (pickedFile.lengthSync() > maxFileSizeInBytes) {
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

      if (pickedFile.lengthSync() < maxFileSizeInBytes) {
        Directory tempDocDir = await getTemporaryDirectory();
        String filePath = result.files.single.path!;
        String tempPortfolioTitle = result.files.single.name;

        String tempPortfolioPath = '${tempDocDir.path}/$tempPortfolioTitle';
        await File(filePath).copy(tempPortfolioPath);

        String tempPortfolioDate =
            DateFormat('yyyy.MM.dd').format(DateTime.now());

        // 값 업데이트
        ResumeTempState tempState = ref.read(resumeTempDataInfoProvider);
        final notifier = ref.read(resumeTempDataInfoProvider.notifier);
        notifier.updateTempPortfolio(
          tempPortfolioPath,
          tempPortfolioTitle,
          tempPortfolioDate,
        );

        tempState = ref.read(resumeTempDataInfoProvider);

        debugPrint(
          ' ===== 임시 포트폴리오 경로 : ${tempState.tempPortfolioPath} ===== ',
        );
        debugPrint(
          ' ===== 임시 포트폴리오 제목 : ${tempState.tempPortfolioTitle} ===== ',
        );
        debugPrint(
          ' ===== 임시 포트폴리오 날짜 : ${tempState.tempPortfolioDate} ===== ',
        );
        debugPrint(
          ' ===== 로컬 데이터 삭제 예정? : ${tempState.isLocalPortfolioDeleted} ===== ',
        );
      } else {
        throw Exception('No file selected or invalid file path.');
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  ///
  /// ToolTip 활성화 조건
  ///
  bool shouldShowTooltip(
    ResumeTempState tempState,
    ResumeLocalState localData, {
    required bool isTempChanged,
  }) {
    bool isTempResumeNull = tempState.tempResumePath == null;
    bool isTempPortfolioNull = tempState.tempPortfolioPath == null;
    bool isLocalStateNotNull = localData.localResumePath.isEmpty &&
        localData.localPortfolioPath.isEmpty;

    // 조건에 따라 true 또는 false 반환
    return (isTempResumeNull != isTempPortfolioNull) &&
        isLocalStateNotNull &&
        isTempChanged == true;
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
  Future<void> testSetAiResumeQuestionUseCase() async {
    // 시작 시간 기록
    final DateTime startTime = DateTime.now();

    // 이력서 TXT 예시 (PDF to TXT)
    const String resumeContent = '''

이름 : 김윤수

주요 강점
요구사항 이해 및 빠른 개발

Flutter 앱 3개 상용화 및 유지 보수 경험.
요구사항을 빠르게 이해하고 기한 내에 구현.
능동적인 아키텍처 설계

선언형 UI 패러다임에 맞는 아키텍처 설계 경험.
코드 품질 및 구조적 개선으로 코드 리뷰 시간 20% 단축.
문서화 생활화

기술 기획 문서를 작성하여 개발 과정 문제를 사전 점검.
체계적인 문서화를 통해 업무 효율 향상.

프로젝트 및 핵심 성과
테크톡 - AI 면접관과 함께 준비하는 개발 면접

팀 프로젝트: 7명 (기획자, 디자이너, Flutter 개발자)
기간: 2024.07.06 ~ 진행 중
성과:
글로벌 서비스 론칭을 위한 easy_localization 패키지 활용.
기존 코드 수정 최소화를 위한 Firestore DB 구조 변경 솔루션 제공.
Whisper API를 활용한 음성 면접 기능 구현으로 응답률 34% → 56% 개선.
핏플 - 자영업자를 위한 근태관리 서비스

팀 프로젝트: 4명
기간: 2024.05.18 ~ 2024.09.19
성과:
Flutter 학습 자료 제작 및 협업 효율성 향상.
클린 아키텍처 설계로 코드 리뷰 시간 20% 단축.
밤하늘 - 목소리로 소통하는 음성 SNS

개인 프로젝트: 1명
기간: 2024.03.27 ~ 2024.06.02
성과:
앱 기획부터 디자인 및 개발까지 독자 수행.
음성 게시물 및 답장 기능 구현.
악성 유저 관리 기능 개발.

기술 스택
Dart & Flutter

Provider, Riverpod, MVVM, Clean Architecture 등.
Hive, Go_router, Dio, Get_it, Freezed, JSON-SERIALIZED.
Firebase

Firestore, Authentication, Storage.
툴
Postman, GitHub, Figma, Jira, Slack.


''';

    // 포트폴리오 TXT 예시 (PDF to TXT)
    const String portfolioContent = '''
이름 : 김윤수 
프로젝트
테크톡 - AI 면접관과 함께 준비하는 개발 면접
팀 프로젝트: 7명 (기획자, 디자이너, Flutter 개발자)
기간: 2024.07.06 ~ 진행 중
설명:
AI 면접, 오답 및 기술 노트를 통해 기술 면접을 대비하는 서비스로, Whisper API를 사용하여 음성 면접 기능을 구현하고 응답률을 34%에서 56%로 개선.
기여 내용:
easy_localization으로 글로벌 서비스 지원.
Firestore DB 구조 변경으로 기존 코드 수정 최소화.
새로운 UI를 디자이너에게 제안하여 UX 개선.
Whisper API로 음성 인식 및 처리 개선.
핏플 - 자영업자를 위한 근태관리 서비스
팀 프로젝트: 4명
기간: 2024.05.18 ~ 2024.09.19
설명:
소상공인을 위한 근태관리 앱. 근무 일정, 출퇴근 기록 관리.
기술 스택:
Dart, Flutter, Riverpod, Firebase, Clean Architecture, Freezed.
기여 내용:
클린 아키텍처 설계로 유지보수성 향상.
통일된 용어 사전 제작으로 협업 효율성 증대.
로그인 및 CRUD 구현.
코드 리뷰 시간 20% 단축.
밤하늘 - 목소리로 소통하는 음성 SNS
개인 프로젝트
기간: 2024.03.27 ~ 2024.06.02
설명:
음성 게시물 작성, 1:1 음성 채팅 등을 통해 소통하는 SNS.
기술 스택:
Dart, Flutter, Provider, Firebase, MVVM, AudioPlayer.
기여 내용:
Figma로 디자인 시스템 구축.
음성 게시물 및 답장 기능 구현.
악성 유저 관리 시스템 개발.
기술 스택
Dart & Flutter
Provider, Riverpod, Clean Architecture, MVVM 등.
Firebase
Firestore, Authentication, Storage.
툴
Postman, GitHub, Figma, Jira, Slack.
''';

    final useCase = CreateResumeQuestionUseCase();

    // 입력 파라미터 생성
    const param =
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
  Future<void> pdfToTxt() async {
    //
  }

  ///
  /// 이력서 프롬프팅 뽑아내기
  ///
  Future<void> startResumeInterview(WidgetRef ref) async {
    // 이력서 로딩 페이지로 이동
    routeToResumeInterviewLoadingPage(ref);

    // TODO: Gemini로 업로드하는 로직도 구현해보기 (yundal)
    // PDF to TXT 진행

    // 프롬프팅 수행
    await testSetAiResumeQuestionUseCase();

    // 완료시 다음 페이지 이동
    routeToResumeChatList(ref);
  }
}
