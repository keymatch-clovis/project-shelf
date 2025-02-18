import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:oxidized/oxidized.dart';
import 'package:project_shelf/database/database.dart';
import 'package:project_shelf/lib/model/field.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product.g.dart';

final validators = {
  "name": FormBuilderValidators.compose([
    FormBuilderValidators.required(),
  ]),
  "value": FormBuilderValidators.compose([
    FormBuilderValidators.min(0, checkNullOrEmpty: false),
  ]),
  "stock": FormBuilderValidators.compose([
    FormBuilderValidators.min(0, checkNullOrEmpty: false),
  ]),
};

class ProductEntity {
  Map<String, Field> fields;

  ProductEntity()
      : fields = {
          "name": Field.empty(),
          "value": Field.empty(),
          "stock": Field.empty(),
          "code": Field.empty(),
        };

  ProductEntity.fromData(ProductData data)
      : fields = {
          "name": Field(value: data.name),
          "value": Field(value: data.value.toString()),
          "stock": Field(value: data.stock.toString()),
          "code": Field(value: data.code),
        };

  bool get isValid => fields.values.every((field) => field.error.isNone());

  Option<String> getError(String key) {
    return fields[key]!.error;
  }
}

class ProductFormState {
  ProductEntity entity = ProductEntity();

  ProductFormState({Option<ProductEntity> entity = const Option.none()}) {
    if (entity.isSome()) {
      this.entity = entity.unwrap();
    }
  }
}

@riverpod
class ProductForm extends _$ProductForm {
  @override
  ProductFormState build({Option<ProductEntity> entity = const Option.none()}) {
    return ProductFormState(entity: entity);
  }

  void validate(String key) {
    final value = state.entity.fields[key]!.value;
    state.entity.fields[key]!.error = Option.from(validators[key]!(value));
    ref.notifyListeners();
  }

  void validateAll() {
    // For every validator, set the entity value.
    validators.forEach((key, validator) {
      // NOTE: If the field is not found, we should throw an exception as this
      // is incorrect code logic.
      final value = state.entity.fields[key]!.value;
      state.entity.fields[key]!.error = Option.from(validator(value));
    });
    ref.notifyListeners();
  }

  void set(String key, String value) {
    final validator = Option.from(validators[key]);
    state.entity.fields[key] = Field(
      value: value.trim(),
      error: validator.andThen((v) => Option.from(v(value))),
    );
    ref.notifyListeners();
  }
}
