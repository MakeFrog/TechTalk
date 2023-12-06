// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'validate_nickname_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$validateNicknameHash() => r'90a91dc597da86d4c4705366bb13775099c1002d';

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

/// See also [validateNickname].
@ProviderFor(validateNickname)
const validateNicknameProvider = ValidateNicknameFamily();

/// See also [validateNickname].
class ValidateNicknameFamily extends Family<AsyncValue<String?>> {
  /// See also [validateNickname].
  const ValidateNicknameFamily();

  /// See also [validateNickname].
  ValidateNicknameProvider call(
    String nickname,
  ) {
    return ValidateNicknameProvider(
      nickname,
    );
  }

  @override
  ValidateNicknameProvider getProviderOverride(
    covariant ValidateNicknameProvider provider,
  ) {
    return call(
      provider.nickname,
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
  String? get name => r'validateNicknameProvider';
}

/// See also [validateNickname].
class ValidateNicknameProvider extends AutoDisposeFutureProvider<String?> {
  /// See also [validateNickname].
  ValidateNicknameProvider(
    String nickname,
  ) : this._internal(
          (ref) => validateNickname(
            ref as ValidateNicknameRef,
            nickname,
          ),
          from: validateNicknameProvider,
          name: r'validateNicknameProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$validateNicknameHash,
          dependencies: ValidateNicknameFamily._dependencies,
          allTransitiveDependencies:
              ValidateNicknameFamily._allTransitiveDependencies,
          nickname: nickname,
        );

  ValidateNicknameProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.nickname,
  }) : super.internal();

  final String nickname;

  @override
  Override overrideWith(
    FutureOr<String?> Function(ValidateNicknameRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ValidateNicknameProvider._internal(
        (ref) => create(ref as ValidateNicknameRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        nickname: nickname,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<String?> createElement() {
    return _ValidateNicknameProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ValidateNicknameProvider && other.nickname == nickname;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, nickname.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ValidateNicknameRef on AutoDisposeFutureProviderRef<String?> {
  /// The parameter `nickname` of this provider.
  String get nickname;
}

class _ValidateNicknameProviderElement
    extends AutoDisposeFutureProviderElement<String?> with ValidateNicknameRef {
  _ValidateNicknameProviderElement(super.provider);

  @override
  String get nickname => (origin as ValidateNicknameProvider).nickname;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
