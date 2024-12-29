import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:techtalk/app/environment/firebase/firebase_options.dart'
    as prod_firebase;
import 'package:techtalk/app/environment/firebase/firebase_options_dev.dart'
    as dev_firebase;

enum Environment {
  dev(type: "DEV"),
  prod(type: "PROD");

  final String type;

  const Environment({
    required this.type,
  });

  String get dotFileName => switch (this) {
        dev => /*'.dev.env'*/ '.env',
        prod => '.env',
      };

  String get firebaseId => switch (this) {
        dev => dotenv.env['FIREBASE_DEV_ID']!,
        prod => dotenv.env['FIREBASE_PROD_ID']!,
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
