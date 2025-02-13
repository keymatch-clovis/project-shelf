import 'package:flutter/material.dart';
import 'package:project_shelf/lib/form_entry.dart';

mixin CustomFormState<T extends StatefulWidget> on State<T> {
  Map<String, FormEntry> formState = {};

  void update(String property, String? value) {
    setState(() {
      if (formState[property] != null) {
        formState[property]!.value = value ?? "";
        formState[property]!.validate();
      } else {
        debugPrint('Invalid property called: $property');
      }
    });
  }

  void validate(String property) {
    setState(() {
      if (formState[property] != null) {
        formState[property]!.validate();
      } else {
        debugPrint('Invalid property called: $property');
      }
    });
  }

  bool validateAll() {
    setState(() {
      // First, validate all entries.
      formState.forEach((_, entry) => entry.validate());
    });
    // Then, see if any of them has errors.
    for (var entry in formState.values) {
      if (entry.error != null) {
        return false;
      }
    }
    return true;
  }
}
