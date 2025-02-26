class ValidationModel {
  String? value;
  String? error;

  ValidationModel(this.value, this.error);

  static ValidationModel createNull() {
    return ValidationModel(null, null);
  }
}
