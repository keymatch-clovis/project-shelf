// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$clientHash() => r'a2093425f077ce4b33d88f27ddf1c1363a57e83e';

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

abstract class _$Client extends BuildlessAutoDisposeNotifier<
    ({ClientDto dto, Option<ClientData> product})> {
  late final InvalidType product;

  ({ClientDto dto, Option<ClientData> product}) build({
    InvalidType product,
  });
}

/// See also [Client].
@ProviderFor(Client)
const clientProvider = ClientFamily();

/// See also [Client].
class ClientFamily
    extends Family<({ClientDto dto, Option<ClientData> product})> {
  /// See also [Client].
  const ClientFamily();

  /// See also [Client].
  ClientProvider call({
    InvalidType product,
  }) {
    return ClientProvider(
      product: product,
    );
  }

  @override
  ClientProvider getProviderOverride(
    covariant ClientProvider provider,
  ) {
    return call(
      product: provider.product,
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
  String? get name => r'clientProvider';
}

/// See also [Client].
class ClientProvider extends AutoDisposeNotifierProviderImpl<Client,
    ({ClientDto dto, Option<ClientData> product})> {
  /// See also [Client].
  ClientProvider({
    InvalidType product,
  }) : this._internal(
          () => Client()..product = product,
          from: clientProvider,
          name: r'clientProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$clientHash,
          dependencies: ClientFamily._dependencies,
          allTransitiveDependencies: ClientFamily._allTransitiveDependencies,
          product: product,
        );

  ClientProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.product,
  }) : super.internal();

  final InvalidType product;

  @override
  ({ClientDto dto, Option<ClientData> product}) runNotifierBuild(
    covariant Client notifier,
  ) {
    return notifier.build(
      product: product,
    );
  }

  @override
  Override overrideWith(Client Function() create) {
    return ProviderOverride(
      origin: this,
      override: ClientProvider._internal(
        () => create()..product = product,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        product: product,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<Client,
      ({ClientDto dto, Option<ClientData> product})> createElement() {
    return _ClientProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ClientProvider && other.product == product;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, product.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ClientRef on AutoDisposeNotifierProviderRef<
    ({ClientDto dto, Option<ClientData> product})> {
  /// The parameter `product` of this provider.
  InvalidType get product;
}

class _ClientProviderElement extends AutoDisposeNotifierProviderElement<Client,
    ({ClientDto dto, Option<ClientData> product})> with ClientRef {
  _ClientProviderElement(super.provider);

  @override
  InvalidType get product => (origin as ClientProvider).product;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
