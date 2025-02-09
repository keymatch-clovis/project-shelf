import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'create_product_form.g.dart';

class FormEntry {
  String value;
  String? error;
  FormFieldValidator<String>? validator;

  FormEntry({required this.value, this.error, this.validator}) {
    if (error != null) {
      this.value = "";
    }
  }

  validate() {
    if (this.validator != null) {
      this.error = this.validator!(this.value.toString());
    }
  }
}

@riverpod
class CreateProductForm extends _$CreateProductForm {
  @override
  Map<String, FormEntry> build() {
    return {
      "name": FormEntry(
        value: "",
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(),
        ]),
      ),
      "value": FormEntry(
        value: "",
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(),
          FormBuilderValidators.positiveNumber(),
          FormBuilderValidators.min(0),
        ]),
      ),
      "stock": FormEntry(
        value: "",
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(),
          FormBuilderValidators.positiveNumber(),
          FormBuilderValidators.min(0),
        ]),
      ),
      "code": FormEntry(
        value: "",
      ),
    };
  }

  void update(String property, String? value) {
    if (state[property] != null) {
      state[property]!.value = value ?? "";
      state[property]!.validate();
      state = {...state};
      return;
    }
    debugPrint('Invalid property called: $property');
  }

  void validate(String property) {
    if (state[property] != null) {
      state[property]!.validate();
      state = {...state};
      return;
    }
    debugPrint('Invalid property called: $property');
  }
}
