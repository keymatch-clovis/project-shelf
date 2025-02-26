// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_mementos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProductMementosState {
  String get productUuid => throw _privateConstructorUsedError;
  List<ProductMementoData> get mementos => throw _privateConstructorUsedError;

  /// Create a copy of ProductMementosState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductMementosStateCopyWith<ProductMementosState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductMementosStateCopyWith<$Res> {
  factory $ProductMementosStateCopyWith(ProductMementosState value,
          $Res Function(ProductMementosState) then) =
      _$ProductMementosStateCopyWithImpl<$Res, ProductMementosState>;
  @useResult
  $Res call({String productUuid, List<ProductMementoData> mementos});
}

/// @nodoc
class _$ProductMementosStateCopyWithImpl<$Res,
        $Val extends ProductMementosState>
    implements $ProductMementosStateCopyWith<$Res> {
  _$ProductMementosStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductMementosState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productUuid = null,
    Object? mementos = null,
  }) {
    return _then(_value.copyWith(
      productUuid: null == productUuid
          ? _value.productUuid
          : productUuid // ignore: cast_nullable_to_non_nullable
              as String,
      mementos: null == mementos
          ? _value.mementos
          : mementos // ignore: cast_nullable_to_non_nullable
              as List<ProductMementoData>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductMementosStateImplCopyWith<$Res>
    implements $ProductMementosStateCopyWith<$Res> {
  factory _$$ProductMementosStateImplCopyWith(_$ProductMementosStateImpl value,
          $Res Function(_$ProductMementosStateImpl) then) =
      __$$ProductMementosStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String productUuid, List<ProductMementoData> mementos});
}

/// @nodoc
class __$$ProductMementosStateImplCopyWithImpl<$Res>
    extends _$ProductMementosStateCopyWithImpl<$Res, _$ProductMementosStateImpl>
    implements _$$ProductMementosStateImplCopyWith<$Res> {
  __$$ProductMementosStateImplCopyWithImpl(_$ProductMementosStateImpl _value,
      $Res Function(_$ProductMementosStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProductMementosState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productUuid = null,
    Object? mementos = null,
  }) {
    return _then(_$ProductMementosStateImpl(
      productUuid: null == productUuid
          ? _value.productUuid
          : productUuid // ignore: cast_nullable_to_non_nullable
              as String,
      mementos: null == mementos
          ? _value._mementos
          : mementos // ignore: cast_nullable_to_non_nullable
              as List<ProductMementoData>,
    ));
  }
}

/// @nodoc

class _$ProductMementosStateImpl
    with DiagnosticableTreeMixin
    implements _ProductMementosState {
  const _$ProductMementosStateImpl(
      {required this.productUuid,
      required final List<ProductMementoData> mementos})
      : _mementos = mementos;

  @override
  final String productUuid;
  final List<ProductMementoData> _mementos;
  @override
  List<ProductMementoData> get mementos {
    if (_mementos is EqualUnmodifiableListView) return _mementos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_mementos);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ProductMementosState(productUuid: $productUuid, mementos: $mementos)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ProductMementosState'))
      ..add(DiagnosticsProperty('productUuid', productUuid))
      ..add(DiagnosticsProperty('mementos', mementos));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductMementosStateImpl &&
            (identical(other.productUuid, productUuid) ||
                other.productUuid == productUuid) &&
            const DeepCollectionEquality().equals(other._mementos, _mementos));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, productUuid, const DeepCollectionEquality().hash(_mementos));

  /// Create a copy of ProductMementosState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductMementosStateImplCopyWith<_$ProductMementosStateImpl>
      get copyWith =>
          __$$ProductMementosStateImplCopyWithImpl<_$ProductMementosStateImpl>(
              this, _$identity);
}

abstract class _ProductMementosState implements ProductMementosState {
  const factory _ProductMementosState(
          {required final String productUuid,
          required final List<ProductMementoData> mementos}) =
      _$ProductMementosStateImpl;

  @override
  String get productUuid;
  @override
  List<ProductMementoData> get mementos;

  /// Create a copy of ProductMementosState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductMementosStateImplCopyWith<_$ProductMementosStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
