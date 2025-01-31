import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/app/localization/app_locale.dart';
import 'package:techtalk/features/youtube/data_source/remote/models/channel_model.dart';
import 'package:techtalk/features/youtube/data_source/remote/models/youtube_detail_model.dart';
import 'package:techtalk/features/youtube/data_source/remote/models/youtube_main_model.dart';
import 'package:techtalk/features/youtube/data_source/remote/models/youtube_qna_model.dart';

///
/// 유튜브 메인 정보 (overview) ref
///
abstract class FirestoreYoutubeRef {
  static const String koName = 'Youtube';
  static const String enName = 'YoutubeEn';

  static CollectionReference<YoutubeMainModel> collection() =>
      FirebaseFirestore.instance
          .collection(AppLocale.isKo ? koName : enName)
          .withConverter(
            fromFirestore: YoutubeMainModel.fromFirestore,
            toFirestore: YoutubeMainModel.toFiresTore,
          );

  static DocumentReference<YoutubeMainModel> doc(String contentId) =>
      FirebaseFirestore.instance
          .collection(AppLocale.isKo ? koName : enName)
          .doc(contentId)
          .withConverter(
            fromFirestore: YoutubeMainModel.fromFirestore,
            toFirestore: YoutubeMainModel.toFiresTore,
          );
}

///
/// 유튜브 콘텐츠 상세(서머리) ref
///
abstract class FirestoreYoutubeDetailNewRef {
  static const String name = 'Detail';

  static DocumentReference<YoutubeDetailModel> doc(String contentId) =>
      FirebaseFirestore.instance
          .collection(AppLocale.isKo
              ? FirestoreYoutubeRef.koName
              : FirestoreYoutubeRef.enName)
          .doc(contentId)
          .collection(name)
          .doc(contentId)
          .withConverter(
            fromFirestore: YoutubeDetailModel.fromFirestore,
            toFirestore: (value, options) => value.toJson(),
          );
}

///
/// 유트브 콘텐츠 문답
///
abstract class FirestoreYoutubeQnaRef {
  static const String name = 'Qna';

  static CollectionReference<YoutubeQnaModel> collection(String contentsId) =>
      FirebaseFirestore.instance
          .collection(
            AppLocale.isKo
                ? FirestoreYoutubeRef.koName
                : FirestoreYoutubeRef.enName,
          )
          .doc(contentsId)
          .collection(name)
          .withConverter(
            fromFirestore: YoutubeQnaModel.fromFirestore,
            toFirestore: (value, options) => value.toJson(),
          );
}

///
/// 채널 정보
///
abstract class FirestoreYoutubeChannelRef {
  static const String koName = 'Channel';
  static const String enName = 'ChannelEn';

  static DocumentReference<ChannelModel> document(String channelId) =>
      FirebaseFirestore.instance
          .collection(
            AppLocale.isKo ? koName : enName,
          )
          .doc(channelId)
          .withConverter(
            fromFirestore: ChannelModel.fromFirestore,
            toFirestore: (value, options) => value.toJson(),
          );
}
