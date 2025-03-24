import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/features/user/repositories/entities/document_entity.dart';
import 'package:techtalk/presentation/pages/resume/providers/resume_info_provider.dart';
import 'package:techtalk/presentation/providers/user/user_info_provider.dart';
import 'package:techtalk/features/user/user.dart';

mixin class ResumeManageState {
  ///
  /// 유저 정보 가져오기
  ///
  UserEntity? user(WidgetRef ref) => ref.watch(userInfoProvider).requireValue;

  ///
  /// 이력서 정보
  ///
  AsyncValue<DocumentEntity?> resumeAsync(WidgetRef ref) =>
      ref.watch(resumeInfoProvider);

  ///
  /// 이력서 데이터 유무 판별
  ///
  bool hasDocument(WidgetRef ref) =>
      ref.read(resumeInfoProvider.notifier).hasDocument();

  ///
  /// 저장하기 버튼 활성화 기준
  ///
  bool isFileChanged(WidgetRef ref) =>
      ref.read(resumeInfoProvider.notifier).isStateChanged();

  ///
  /// 툴팁 활성화 기준
  ///
  bool showTooltip(WidgetRef ref) =>
      ref.read(resumeInfoProvider.notifier).showTooltip();
}
