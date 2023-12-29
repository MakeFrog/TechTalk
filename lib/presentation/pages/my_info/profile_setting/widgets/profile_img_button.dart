part of '../profile_setting_page.dart';

class _ProfileImgButton extends ConsumerWidget
    with ProfileSettingState, ProfileSettingEvent {
  const _ProfileImgButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        onProfileImgTapped(ref);
      },
      child: Align(
        child: Builder(
          builder: (context) {
            const double imgSize = 120;

            final pickedImg = pickedImgFile(ref);
            final currentProfileImgUrl = user(ref).profileImgUrl;

            /// 불러온 로컬 이미지 파일이 없다면,
            /// 현재 유저의 프로필 이미지를 노출
            if (pickedImg == null) {
              return Stack(
                children: [
                  RoundProfileImg(
                    size: 120,
                    imgUrl: currentProfileImgUrl,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: SvgPicture.asset(Assets.iconsRoundedCamera),
                  )
                ],
              );
            } else {
              /// PICKED IMAGE
              return ClipRRect(
                borderRadius: BorderRadius.circular(imgSize / 2),
                child: Image.file(
                  pickedImg,
                  height: imgSize,
                  width: imgSize,
                  fit: BoxFit.cover,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
