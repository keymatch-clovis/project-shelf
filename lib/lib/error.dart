import 'package:flutter/material.dart';

enum CustomError {
  BLUETOOTH_NOT_ACTIVE_ERROR,
}

enum PrintError {
  COULD_NOT_CONNECT_TO_PRINTER,
  NO_COMPANY_NAME,
  NO_COMPANY_DOCUMENT,
  NO_COMPANY_EMAIL,
  NO_COMPANY_PHONE,
}

enum FileLoadError {
  FILE_NOT_SELECTED,
  BROKEN_FILE,
  INCORRECT_FILE_FORMAT,
}

enum ProductError {
  PRODUCT_IS_REFERENCED_IN_INVOICES;

  void showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          switch (this) {
            ProductError.PRODUCT_IS_REFERENCED_IN_INVOICES =>
              "El producto no se puede eliminar porque se encuentra en algunas facturas."
          },
        ),
      ),
    );
  }
}
