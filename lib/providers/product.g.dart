// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productFormHash() => r'f2c4691af5a70b88c2419c8be7bd984a7c76b722';

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

abstract class _$ProductForm
    extends BuildlessAutoDisposeNotifier<ProductFormState> {
  late final Option<ProductEntity> entity;

  ProductFormState build({
    Option<ProductEntity> entity = const Option.none(),
  });
}

/// See also [ProductForm].
@ProviderFor(ProductForm)
const productFormProvider = ProductFormFamily();

/// See also [ProductForm].
class ProductFormFamily extends Family<ProductFormState> {
  /// See also [ProductForm].
  const ProductFormFamily();

  /// See also [ProductForm].
  ProductFormProvider call({
    Option<ProductEntity> entity = const Option.none(),
  }) {
    return ProductFormProvider(
      entity: entity,
    );
  }

  @override
  ProductFormProvider getProviderOverride(
    covariant ProductFormProvider provider,
  ) {
    return call(
      entity: provider.entity,
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
  String? get name => r'productFormProvider';
}

/// See also [ProductForm].
class ProductFormProvider
    extends AutoDisposeNotifierProviderImpl<ProductForm, ProductFormState> {
  /// See also [ProductForm].
  ProductFormProvider({
    Option<ProductEntity> entity = const Option.none(),
  }) : this._internal(
          () => ProductForm()..entity = entity,
          from: productFormProvider,
          name: r'productFormProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$productFormHash,
          dependencies: ProductFormFamily._dependencies,
          allTransitiveDependencies:
              ProductFormFamily._allTransitiveDependencies,
          entity: entity,
        );

  ProductFormProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.entity,
  }) : super.internal();

  final Option<ProductEntity> entity;

  @override
  ProductFormState runNotifierBuild(
    covariant ProductForm notifier,
  ) {
    return notifier.build(
      entity: entity,
    );
  }

  @override
  Override overrideWith(ProductForm Function() create) {
    return ProviderOverride(
      origin: this,
      override: ProductFormProvider._internal(
        () => create()..entity = entity,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        entity: entity,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<ProductForm, ProductFormState>
      createElement() {
    return _ProductFormProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductFormProvider && other.entity == entity;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, entity.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ProductFormRef on AutoDisposeNotifierProviderRef<ProductFormState> {
  /// The parameter `entity` of this provider.
  Option<ProductEntity> get entity;
}

class _ProductFormProviderElement
    extends AutoDisposeNotifierProviderElement<ProductForm, ProductFormState>
    with ProductFormRef {
  _ProductFormProviderElement(super.provider);

  @override
  Option<ProductEntity> get entity => (origin as ProductFormProvider).entity;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
