// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_mementos.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productMementosHash() => r'2532e345dfcaa5a48c95820cbbb26aa4d2416a9f';

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

abstract class _$ProductMementos
    extends BuildlessAutoDisposeAsyncNotifier<ProductMementosState> {
  late final String productUuid;

  FutureOr<ProductMementosState> build(
    String productUuid,
  );
}

/// See also [ProductMementos].
@ProviderFor(ProductMementos)
const productMementosProvider = ProductMementosFamily();

/// See also [ProductMementos].
class ProductMementosFamily extends Family<AsyncValue<ProductMementosState>> {
  /// See also [ProductMementos].
  const ProductMementosFamily();

  /// See also [ProductMementos].
  ProductMementosProvider call(
    String productUuid,
  ) {
    return ProductMementosProvider(
      productUuid,
    );
  }

  @override
  ProductMementosProvider getProviderOverride(
    covariant ProductMementosProvider provider,
  ) {
    return call(
      provider.productUuid,
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
  String? get name => r'productMementosProvider';
}

/// See also [ProductMementos].
class ProductMementosProvider extends AutoDisposeAsyncNotifierProviderImpl<
    ProductMementos, ProductMementosState> {
  /// See also [ProductMementos].
  ProductMementosProvider(
    String productUuid,
  ) : this._internal(
          () => ProductMementos()..productUuid = productUuid,
          from: productMementosProvider,
          name: r'productMementosProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$productMementosHash,
          dependencies: ProductMementosFamily._dependencies,
          allTransitiveDependencies:
              ProductMementosFamily._allTransitiveDependencies,
          productUuid: productUuid,
        );

  ProductMementosProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.productUuid,
  }) : super.internal();

  final String productUuid;

  @override
  FutureOr<ProductMementosState> runNotifierBuild(
    covariant ProductMementos notifier,
  ) {
    return notifier.build(
      productUuid,
    );
  }

  @override
  Override overrideWith(ProductMementos Function() create) {
    return ProviderOverride(
      origin: this,
      override: ProductMementosProvider._internal(
        () => create()..productUuid = productUuid,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        productUuid: productUuid,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<ProductMementos, ProductMementosState>
      createElement() {
    return _ProductMementosProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductMementosProvider && other.productUuid == productUuid;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, productUuid.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ProductMementosRef
    on AutoDisposeAsyncNotifierProviderRef<ProductMementosState> {
  /// The parameter `productUuid` of this provider.
  String get productUuid;
}

class _ProductMementosProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ProductMementos,
        ProductMementosState> with ProductMementosRef {
  _ProductMementosProviderElement(super.provider);

  @override
  String get productUuid => (origin as ProductMementosProvider).productUuid;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
