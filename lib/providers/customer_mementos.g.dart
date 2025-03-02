// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_mementos.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$customerMementosHash() => r'ae37f7a8528bc85afc34c2480f281affe2990d90';

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

abstract class _$CustomerMementos
    extends BuildlessAutoDisposeAsyncNotifier<CustomerMementosState> {
  late final String customerUuid;

  FutureOr<CustomerMementosState> build(
    String customerUuid,
  );
}

/// See also [CustomerMementos].
@ProviderFor(CustomerMementos)
const customerMementosProvider = CustomerMementosFamily();

/// See also [CustomerMementos].
class CustomerMementosFamily extends Family<AsyncValue<CustomerMementosState>> {
  /// See also [CustomerMementos].
  const CustomerMementosFamily();

  /// See also [CustomerMementos].
  CustomerMementosProvider call(
    String customerUuid,
  ) {
    return CustomerMementosProvider(
      customerUuid,
    );
  }

  @override
  CustomerMementosProvider getProviderOverride(
    covariant CustomerMementosProvider provider,
  ) {
    return call(
      provider.customerUuid,
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
  String? get name => r'customerMementosProvider';
}

/// See also [CustomerMementos].
class CustomerMementosProvider extends AutoDisposeAsyncNotifierProviderImpl<
    CustomerMementos, CustomerMementosState> {
  /// See also [CustomerMementos].
  CustomerMementosProvider(
    String customerUuid,
  ) : this._internal(
          () => CustomerMementos()..customerUuid = customerUuid,
          from: customerMementosProvider,
          name: r'customerMementosProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$customerMementosHash,
          dependencies: CustomerMementosFamily._dependencies,
          allTransitiveDependencies:
              CustomerMementosFamily._allTransitiveDependencies,
          customerUuid: customerUuid,
        );

  CustomerMementosProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.customerUuid,
  }) : super.internal();

  final String customerUuid;

  @override
  FutureOr<CustomerMementosState> runNotifierBuild(
    covariant CustomerMementos notifier,
  ) {
    return notifier.build(
      customerUuid,
    );
  }

  @override
  Override overrideWith(CustomerMementos Function() create) {
    return ProviderOverride(
      origin: this,
      override: CustomerMementosProvider._internal(
        () => create()..customerUuid = customerUuid,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        customerUuid: customerUuid,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<CustomerMementos,
      CustomerMementosState> createElement() {
    return _CustomerMementosProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CustomerMementosProvider &&
        other.customerUuid == customerUuid;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, customerUuid.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CustomerMementosRef
    on AutoDisposeAsyncNotifierProviderRef<CustomerMementosState> {
  /// The parameter `customerUuid` of this provider.
  String get customerUuid;
}

class _CustomerMementosProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<CustomerMementos,
        CustomerMementosState> with CustomerMementosRef {
  _CustomerMementosProviderElement(super.provider);

  @override
  String get customerUuid => (origin as CustomerMementosProvider).customerUuid;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
