// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_study_topic_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$selectedStudyTopicIdHash() =>
    r'eba5358ffd686b95d9ddd1dde0c8dffc8a044578';

/// See also [selectedStudyTopicId].
@ProviderFor(selectedStudyTopicId)
final selectedStudyTopicIdProvider = AutoDisposeProvider<String>.internal(
  selectedStudyTopicId,
  name: r'selectedStudyTopicIdProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedStudyTopicIdHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SelectedStudyTopicIdRef = AutoDisposeProviderRef<String>;
String _$testHash() => r'd76ece4e700a00f7adef9106e8e5d3e1791735d4';

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

/// See also [test].
@ProviderFor(test)
const testProvider = TestFamily();

/// See also [test].
class TestFamily extends Family<String> {
  /// See also [test].
  const TestFamily();

  /// See also [test].
  TestProvider call({
    required String value,
  }) {
    return TestProvider(
      value: value,
    );
  }

  @override
  TestProvider getProviderOverride(
    covariant TestProvider provider,
  ) {
    return call(
      value: provider.value,
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
  String? get name => r'testProvider';
}

/// See also [test].
class TestProvider extends AutoDisposeProvider<String> {
  /// See also [test].
  TestProvider({
    required String value,
  }) : this._internal(
          (ref) => test(
            ref as TestRef,
            value: value,
          ),
          from: testProvider,
          name: r'testProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product') ? null : _$testHash,
          dependencies: TestFamily._dependencies,
          allTransitiveDependencies: TestFamily._allTransitiveDependencies,
          value: value,
        );

  TestProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.value,
  }) : super.internal();

  final String value;

  @override
  Override overrideWith(
    String Function(TestRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TestProvider._internal(
        (ref) => create(ref as TestRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        value: value,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<String> createElement() {
    return _TestProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TestProvider && other.value == value;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, value.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TestRef on AutoDisposeProviderRef<String> {
  /// The parameter `value` of this provider.
  String get value;
}

class _TestProviderElement extends AutoDisposeProviderElement<String>
    with TestRef {
  _TestProviderElement(super.provider);

  @override
  String get value => (origin as TestProvider).value;
}

String _$selectedStudyTopicHash() =>
    r'01bcb33982e750456c81912e04d8b8f9212707ba';

/// See also [SelectedStudyTopic].
@ProviderFor(SelectedStudyTopic)
final selectedStudyTopicProvider =
    AutoDisposeNotifierProvider<SelectedStudyTopic, InterviewTopic>.internal(
  SelectedStudyTopic.new,
  name: r'selectedStudyTopicProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedStudyTopicHash,
  dependencies: <ProviderOrFamily>[selectedStudyTopicIdProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    selectedStudyTopicIdProvider,
    ...?selectedStudyTopicIdProvider.allTransitiveDependencies
  },
);

typedef _$SelectedStudyTopic = AutoDisposeNotifier<InterviewTopic>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
