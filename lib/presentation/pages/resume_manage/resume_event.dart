// import 'dart:io';
// import 'package:file_picker/file_picker.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:techtalk/presentation/providers/user/user_info_provider.dart';

// mixin class ResumeEvent {
//   ///
//   /// 이력서 업로드
//   ///
//   Future<void> uploadResumePdfFile(WidgetRef ref) async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['pdf'],
//     );

//     if (result != null) {
//       Directory appDocDir = await getApplicationDocumentsDirectory();
//       for (var file in result.files) {
//         String filePath = file.path!;
//         String savedFilePath = '${appDocDir.path}/${file.name}';

//         // 파일 이름에서 확장자를 제거 (.pdf 제거)
//         String fileNameWithoutExtension = file.name.replaceAll('.pdf', '');

//         // PDF 파일을 로컬에 저장
//         File savedFile = await File(filePath).copy(savedFilePath);
//         print('savedFilePath : $savedFilePath');

//         // 날짜를 년/월/일 형식으로 가져오기
//         final uploadDate = DateTime.now();
//         final dateFormatted = DateTime(
//           uploadDate.year,
//           uploadDate.month,
//           uploadDate.day,
//         );

//         // 이력서 정보 Map 생성
//         final resumeInfo = {
//           'name': fileNameWithoutExtension,
//           'date': dateFormatted,
//           'directory': savedFilePath,
//         };

//         // 이력서 정보 저장 로직
//         await ref
//             .read(userInfoProvider.notifier)
//             .storeLocalResumeInfo(resumeInfo);
//       }
//     }
//   }

//   ///
//   /// 포트폴리오 업로드
//   ///
//   Future<void> uploadPortfolioFile(WidgetRef ref) async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['pdf'],
//     );

//     if (result != null) {
//       Directory appDocDir = await getApplicationDocumentsDirectory();
//       for (var file in result.files) {
//         String filePath = file.path!;
//         String savedFilePath = '${appDocDir.path}/${file.name}';

//         // 파일 이름에서 확장자를 제거 (.pdf 제거)
//         String fileNameWithoutExtension = file.name.replaceAll('.pdf', '');

//         // PDF 파일을 로컬에 저장
//         File savedFile = await File(filePath).copy(savedFilePath);
//         print('savedFilePath : $savedFilePath');

//         // 날짜를 년/월/일 형식으로 가져오기
//         final uploadDate = DateTime.now();
//         final dateFormatted = DateTime(
//           uploadDate.year,
//           uploadDate.month,
//           uploadDate.day,
//         );

//         // 포트폴리오 정보 Map 생성
//         final portfolioInfo = {
//           'name': fileNameWithoutExtension,
//           'date': dateFormatted,
//           'directory': savedFilePath,
//         };

//         // 포트폴리오 정보 저장 로직
//         await ref
//             .read(userInfoProvider.notifier)
//             .storeLocalPortfolioInfo(portfolioInfo);
//       }
//     }
//   }

//   /// 앱바 뒤로 가기 버튼이 클릭되었을 때
//   Future<void> onAppbarBackBtnTapped(WidgetRef ref) async {
//     await ref.read(userInfoProvider.notifier).initializeLocalResumeInfo();
//     await ref.read(userInfoProvider.notifier).initializeLocalPortfolioInfo();
//   }
// }
