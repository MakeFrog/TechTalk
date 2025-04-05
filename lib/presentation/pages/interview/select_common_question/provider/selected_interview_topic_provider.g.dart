// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_interview_topic_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$selectedInterviewTopicHash() =>
    r'249d3c7e1e3bbb24abb2e3880c125bb0e6e4153d';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$SelectedInterviewTopic
    extends BuildlessAutoDisposeNotifier<TopicEntity> {
  late final TopicEntity topic;

  TopicEntity build(
    TopicEntity topic,
  );
}

/// See also [SelectedInterviewTopic].
@ProviderFor(SelectedInterviewTopic)
const selectedInterviewTopicProvider = SelectedInterviewTopicFamily();

/// See also [SelectedInterviewTopic].
class SelectedInterviewTopicFamily extends Family<TopicEntity> {
  /// See also [SelectedInterviewTopic].
  const SelectedInterviewTopicFamily();

  /// See also [SelectedInterviewTopic].
  SelectedInterviewTopicProvider call(
    TopicEntity topic,
  ) {
    return SelectedInterviewTopicProvider(
      topic,
    );
  }

  @override
  SelectedInterviewTopicProvider getProviderOverride(
    covariant SelectedInterviewTopicProvider provider,
  ) {
    return call(
      provider.topic,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'selectedInterviewTopicProvider';
}

/// See also [SelectedInterviewTopic].
class SelectedInterviewTopicProvider extends AutoDisposeNotifierProviderImpl<
    SelectedInterviewTopic, TopicEntity> {
  /// See also [SelectedInterviewTopic].
  SelectedInterviewTopicProvider(
    TopicEntity topic,
  ) : this._internal(
          () => SelectedInterviewTopic()..topic = topic,
          from: selectedInterviewTopicProvider,
          name: r'selectedInterviewTopicProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$selectedInterviewTopicHash,
          dependencies: SelectedInterviewTopicFamily._dependencies,
          allTransitiveDependencies:
              SelectedInterviewTopicFamily._allTransitiveDependencies,
          topic: topic,
        );

  SelectedInterviewTopicProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.topic,
  }) : super.internal();

  final TopicEntity topic;

  @override
  TopicEntity runNotifierBuild(
    covariant SelectedInterviewTopic notifier,
  ) {
    return notifier.build(
      topic,
    );
  }

  @override
  Override overrideWith(SelectedInterviewTopic Function() create) {
    return ProviderOverride(
      origin: this,
      override: SelectedInterviewTopicProvider._internal(
        () => create()..topic = topic,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        topic: topic,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<SelectedInterviewTopic, TopicEntity>
      createElement() {
    return _SelectedInterviewTopicProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SelectedInterviewTopicProvider && other.topic == topic;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, topic.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SelectedInterviewTopicRef on AutoDisposeNotifierProviderRef<TopicEntity> {
  /// The parameter `topic` of this provider.
  TopicEntity get topic;
}

class _SelectedInterviewTopicProviderElement
    extends AutoDisposeNotifierProviderElement<SelectedInterviewTopic,
        TopicEntity> with SelectedInterviewTopicRef {
  _SelectedInterviewTopicProviderElement(super.provider);

  @override
  TopicEntity get topic => (origin as SelectedInterviewTopicProvider).topic;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
