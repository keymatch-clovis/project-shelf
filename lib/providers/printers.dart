import 'package:oxidized/oxidized.dart';
import 'package:project_shelf/data/error.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

part "printers.g.dart";

@riverpod
class Printers extends _$Printers {
  @override
  Future<Result<List<BluetoothInfo>, CustomError>> build() {
    return _getDevices();
  }

  Future<Result<List<BluetoothInfo>, CustomError>> _getDevices() async {
    final isBluetoothEnabled = await PrintBluetoothThermal.bluetoothEnabled;
    if (!isBluetoothEnabled) {
      return Err(CustomError.BLUETOOTH_NOT_ACTIVE_ERROR);
    }

    return Ok(await PrintBluetoothThermal.pairedBluetooths);
  }
}
