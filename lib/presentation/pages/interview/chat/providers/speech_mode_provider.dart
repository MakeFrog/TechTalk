import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'speech_mode_provider.g.dart';

@riverpod
class IsSpeechMode extends _$IsSpeechMode {
  // ignore: avoid_public_notifier_properties
  bool? isPermissionGranted ;

  @override
  bool build() => false;

  void toggle() {
    state = !state;
  }
}
