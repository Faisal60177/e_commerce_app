// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(authStatus)
final authStatusProvider = AuthStatusProvider._();

final class AuthStatusProvider
    extends $FunctionalProvider<AuthStatus, AuthStatus, AuthStatus>
    with $Provider<AuthStatus> {
  AuthStatusProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authStatusProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authStatusHash();

  @$internal
  @override
  $ProviderElement<AuthStatus> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthStatus create(Ref ref) {
    return authStatus(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthStatus value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthStatus>(value),
    );
  }
}

String _$authStatusHash() => r'e8868471262d2ceb2ac5c49ffbbfe5f5ba0c8275';

@ProviderFor(authRepository)
final authRepositoryProvider = AuthRepositoryProvider._();

final class AuthRepositoryProvider
    extends $FunctionalProvider<AuthRepository, AuthRepository, AuthRepository>
    with $Provider<AuthRepository> {
  AuthRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authRepositoryHash();

  @$internal
  @override
  $ProviderElement<AuthRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthRepository create(Ref ref) {
    return authRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthRepository>(value),
    );
  }
}

String _$authRepositoryHash() => r'9d8eb246c731caeb14539589dc540f9bf743d01f';

@ProviderFor(googleSignInService)
final googleSignInServiceProvider = GoogleSignInServiceProvider._();

final class GoogleSignInServiceProvider
    extends
        $FunctionalProvider<
          GoogleSignInService,
          GoogleSignInService,
          GoogleSignInService
        >
    with $Provider<GoogleSignInService> {
  GoogleSignInServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'googleSignInServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$googleSignInServiceHash();

  @$internal
  @override
  $ProviderElement<GoogleSignInService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GoogleSignInService create(Ref ref) {
    return googleSignInService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoogleSignInService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoogleSignInService>(value),
    );
  }
}

String _$googleSignInServiceHash() =>
    r'03fb17a726b4b05906305db6d58aeda1d6f66866';

@ProviderFor(authUser)
final authUserProvider = AuthUserProvider._();

final class AuthUserProvider
    extends
        $FunctionalProvider<AsyncValue<AppUser?>, AppUser?, Stream<AppUser?>>
    with $FutureModifier<AppUser?>, $StreamProvider<AppUser?> {
  AuthUserProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authUserProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authUserHash();

  @$internal
  @override
  $StreamProviderElement<AppUser?> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<AppUser?> create(Ref ref) {
    return authUser(ref);
  }
}

String _$authUserHash() => r'a9cb0916c3f06249eba4ad8d54e41b87d7197b08';

@ProviderFor(currentUid)
final currentUidProvider = CurrentUidProvider._();

final class CurrentUidProvider
    extends $FunctionalProvider<String?, String?, String?>
    with $Provider<String?> {
  CurrentUidProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentUidProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentUidHash();

  @$internal
  @override
  $ProviderElement<String?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String? create(Ref ref) {
    return currentUid(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$currentUidHash() => r'56d78ab26dcda8395c6462426a930912e1ae44d5';
