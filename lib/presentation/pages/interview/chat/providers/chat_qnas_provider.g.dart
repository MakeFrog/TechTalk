// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_qnas_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chatQnasHash() => r'1b38cd2abef31587eb1905e36ef77d0473cc463f';

///
/// 채팅 Qna 리스트
///
///
/// Copied from [ChatQnas].
@ProviderFor(ChatQnas)
final chatQnasProvider =
    AutoDisposeAsyncNotifierProvider<ChatQnas, List<ChatQnaEntity>>.internal(
  ChatQnas.new,
  name: r'chatQnasProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$chatQnasHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ChatQnas = AutoDisposeAsyncNotifier<List<ChatQnaEntity>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
