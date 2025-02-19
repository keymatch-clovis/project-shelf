// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductImpl _$$ProductImplFromJson(Map<String, dynamic> json) =>
    _$ProductImpl(
      name: json['name'] as String,
      value: (json['value'] as num).toInt(),
      stock: (json['stock'] as num).toInt(),
      code: json['code'] as String? ?? "",
    );

Map<String, dynamic> _$$ProductImplToJson(_$ProductImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'value': instance.value,
      'stock': instance.stock,
      'code': instance.code,
    };
