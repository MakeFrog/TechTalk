import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:techtalk/app/environment/environment.enum.dart';
import 'package:techtalk/app/environment/flavor.dart';
import 'package:techtalk/app/localization/app_locale.dart';
import 'dart:convert';
import 'package:techtalk/core/constants/slack_notification_type.enum.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/user/repositories/entities/user_entity.dart';

///
/// 슬랙 노티피케이션 알람 모듈
/// TODO: 추후 리팩토링 필요
///

abstract class SlackNotificationService {
  static UserEntity? userInfo;

  // Slack 알림을 보내는 함수
  static Future<void> sendNotification(
      {UserEntity? targetUserInfo,
      String? message,
      required SlackNotificationType type}) async {
    // 데브 또는 디버그 모드에서는 이벤트 실행 X
    if(kDebugMode.isTrue || Flavor.env == Environment.dev) return;
    // 웹후크 URL
    final url = Uri.parse(
        'https://hooks.slack.com/services/T071LHJ83KK/B07QPDR2KBM/${Environment.prod.slackNotificationKey}');

    final targetMessage = switch (type) {
      SlackNotificationType.login => () async {
          userInfo = targetUserInfo;
          return targetUserInfo == null
              ? '익명의 유저가 로그인을 했습니다'
              : '${userInfo!.loginCount ?? 0 + 1}번째 로그인을 했습니다 (마지막 접속일 : ${timeAgo(userInfo!.lastLoginDate)})';
        },
      SlackNotificationType.event => () async {
          return message ?? '등록이 필요한 이벤트 입니다';
        },
      SlackNotificationType.signUp => () async {
          userInfo = targetUserInfo;
          return '새로운 유저가 회원가입을 진행했어요!';
        },
      SlackNotificationType.withdraw => () async {
          clear();
          return '회원탈퇴 했어요';
        },
      SlackNotificationType.logOut => () async {
          clear();
          return '로그아웃 했어요';
        },
    };

    // JSON 페이로드 생성
    final payload = {
      'channel': '이벤트-로그',
      // 메시지를 보낼 채널
      'username':
          '${userInfo?.nickname ?? targetUserInfo?.nickname ?? '익명'}(${AppLocale.currentLocale.countryCode}/${AppLocale.currentLocale.languageCode})',
      // 사용자 이름
      'text': await targetMessage(),
      // Slack에 표시될 텍스트
      'icon_emoji': type.icon,
      // 이모지
    };

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(payload),
    );

    if (response.statusCode == 200) {
      log('Slack notification sent successfully');
    } else {
      log('Failed to send notification: ${response.statusCode}');
    }
  }

  static void updateUserInfo(UserEntity? info) {
    userInfo = info;
  }

  static void clear() {
    userInfo = null;
  }
}

String timeAgo(DateTime inputTime) {
  final now = DateTime.now();
  final difference = now.difference(inputTime);

  if (difference.inSeconds < 60) {
    return '${difference.inSeconds}초 전';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes}분 전';
  } else if (difference.inHours < 24) {
    return '${difference.inHours}시간 전';
  } else if (difference.inDays < 7) {
    return '${difference.inDays}일 전';
  } else if (difference.inDays < 30) {
    return '${(difference.inDays / 7).floor()}주 전';
  } else if (difference.inDays < 365) {
    return '${(difference.inDays / 30).floor()}개월 전';
  } else {
    return '${(difference.inDays / 365).floor()}년 전';
  }
}
