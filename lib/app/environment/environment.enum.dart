import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:techtalk/app/environment/firebase/firebase_options.dart'
    as prod_firebase;
import 'package:techtalk/app/environment/firebase/firebase_options_dev.dart'
    as dev_firebase;

enum Environment {
  dev(type: "DEV", firebaseId: "techtalk-dev-33"),
  prod(type: "PROD", firebaseId: "techtalk-prod-32");

  final String type;
  final String firebaseId;

  const Environment({
    required this.type,
    required this.firebaseId,
  });

  String get dotFileName => switch (this) {
        dev => /*'.dev.env'*/ '.env',
        prod => '.env',
      };

  String get openApiKey => switch (this) {
        dev => dotenv.env['OPENAPI_KEY']!,
        prod => dotenv.env['OPENAPI_KEY']!,
      };

  String get geminiApiKey => switch (this) {
        dev => dotenv.env['GEMINI_API_KEY']!,
        prod => dotenv.env['GEMINI_API_KEY']!,
      };

  String get slackNotificationKey => switch (this) {
        dev => dotenv.env['SLACK_NOTIFICATION_KEY']!,
        prod => dotenv.env['SLACK_NOTIFICATION_KEY']!,
      };

  FirebaseOptions get firebaseOption => switch (this) {
        prod => prod_firebase.DefaultFirebaseOptions.currentPlatform,
        dev => dev_firebase.DefaultFirebaseOptions.currentPlatform,
      };
}
