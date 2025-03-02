import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:flutter/services.dart';
import "package:image/image.dart";
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

part "printers.g.dart";

@riverpod
class Printers extends _$Printers {
  @override
  List<String> build() {
    return [];
  }

  Future<void> startScan() async {
    final isBluetoothEnabled = await PrintBluetoothThermal.bluetoothEnabled;
    print(isBluetoothEnabled);

    if (isBluetoothEnabled) {
      final listResult = await PrintBluetoothThermal.pairedBluetooths;
      for (final result in listResult) {
        print(result.name);
        print(result.macAdress);
      }

      final paired = await PrintBluetoothThermal.connect(
        macPrinterAddress: "86:67:7A:F2:A2:4D",
      );
      print(paired);

      List<int> bytes = [];
      final profile = await CapabilityProfile.load();
      final generator = Generator(PaperSize.mm58, profile);

      final data = await rootBundle.load('assets/logo.jpeg');
      final bytesImg = data.buffer.asUint8List();

      final t = await (Command()
            ..decodeImage(bytesImg)
            ..copyResize(width: 320)
            ..grayscale(amount: 100)
            )
          .getImage();

      bytes += generator.image(t!);

      bytes += generator.reset();
      bytes += generator.text("Regular: Hola uwu");
      bytes += generator.feed(3);
      await PrintBluetoothThermal.writeBytes(bytes);

      await PrintBluetoothThermal.disconnect;
    }
  }
}
