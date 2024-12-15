// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'one_line_feedback_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$oneLineFeedbackHash() => r'6afd9cbaf360b96eff8f3d58b1d20f360f9d06c0';

///
/// Ai 면접관 한줄 피드백을 stream 형태로 리턴
///
///
/// Copied from [OneLineFeedback].
@ProviderFor(OneLineFeedback)
final oneLineFeedbackProvider = AutoDisposeNotifierProvider<OneLineFeedback,
    BehaviorSubject<String>>.internal(
  OneLineFeedback.new,
  name: r'oneLineFeedbackProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$oneLineFeedbackHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$OneLineFeedback = AutoDisposeNotifier<BehaviorSubject<String>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
