import 'dart:async';
import 'dart:io';

import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/user/user.dart';

///
/// 유저 정보를 수정하는 useCase
/// [ProfileSettingPage] 영역에서 사용됨
///
class EditUserProfileUseCase extends BaseUseCase<
    ({UserEntity user, File? imageFile}), Result<UserEntity>> {
  EditUserProfileUseCase(this._repository);

  final UserRepository _repository;

  @override
  FutureOr<Result<UserEntity>> call(
      ({File? imageFile, UserEntity user}) request) async {
    UserEntity user;

    user = request.user;

    /// 전달 받은 이미지 파일이 있다면
    /// database store에 이미지를 저장하고 url 주소를 반환
    if (request.imageFile != null) {
      final response =
          await _repository.uploadImgFileAndGetUrl(request.imageFile!);
      final imgUrl = response.getOrThrow();
      user = request.user.copyWith(profileImgUrl: imgUrl);
    }

    final response = await _repository.updateUser(user);

    return response.fold(
      onSuccess: (_) {
        return Result.success(user);
      },
      onFailure: Result.failure,
    );
  }
}
