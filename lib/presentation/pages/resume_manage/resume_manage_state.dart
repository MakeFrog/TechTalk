import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/features/user/repositories/entities/document_entity.dart';
import 'package:techtalk/presentation/pages/resume_manage/providers/resume_info_provider.dart';
import 'package:techtalk/presentation/providers/user/user_info_provider.dart';
import 'package:techtalk/features/user/user.dart';

mixin class ResumeManageState {
  ///
  /// 유저 정보 가져오기
  ///
  UserEntity? user(WidgetRef ref) => ref.watch(userInfoProvider).requireValue;

  ///
  /// 이력서 로컬 데이터 불러오기
  ///
  DocumentEntity loadDocumentData(WidgetRef ref) =>
      ref.watch(resumeInfoProvider);
}
