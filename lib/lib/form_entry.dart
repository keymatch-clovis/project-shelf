import 'package:flutter/material.dart';

class FormEntry {
  String value;
  String? error;
  FormFieldValidator<String>? validator;

  FormEntry({this.value = "", this.error, this.validator}) {
    if (error != null) {
      this.value = "";
    }
  }

  validate() {
    if (this.validator != null) {
      this.error = this.validator!(this.value);
    }
  }
}

