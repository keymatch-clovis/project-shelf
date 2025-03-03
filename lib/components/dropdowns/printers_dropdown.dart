import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
import 'package:project_shelf/providers/preferences.dart';
import 'package:project_shelf/providers/printers.dart';

// NOTE: This can be a little contribution to the library -- create this
// operator to make it easier to compare the bluetooth info.
class Device extends BluetoothInfo {
  Device({required super.name, required super.macAdress});

  factory Device.from(BluetoothInfo info) {
    return Device(name: info.name, macAdress: info.macAdress);
  }

  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) {
    if (other is BluetoothInfo) {
      return other.name == this.name && other.macAdress == this.macAdress;
    }
    return false;
  }
}

class PrintersDropdown extends ConsumerWidget {
  const PrintersDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final printers = ref.watch(printersProvider);
    final preferences = ref.watch(preferencesProvider.select((value) {
      return value.whenData((preferences) {
        if (preferences.containsKey(PreferenceName.DEFAULT_PRINTER_NAME) &&
            preferences.containsKey(PreferenceName.DEFAULT_PRINTER_MAC)) {
          return Device(
            name: preferences[PreferenceName.DEFAULT_PRINTER_NAME]!,
            macAdress: preferences[PreferenceName.DEFAULT_PRINTER_MAC]!,
          );
        }
        return null;
      });
    }));

    bool hasValue() => printers.hasValue && preferences.hasValue;

    if (!hasValue()) {
      return Stack(
        alignment: AlignmentDirectional.center,
        children: [
          DropdownMenu(
            enabled: false,
            label: Text("Impresora"),
            dropdownMenuEntries: [],
          ),
          Center(child: CircularProgressIndicator.adaptive()),
        ],
      );
    }

    return DropdownMenu(
      label: Text("Impresora"),
      initialSelection: preferences.value,
      onSelected: (device) async {
        if (device == null) {
          return;
        }

        await ref.read(preferencesProvider.notifier).set(
              key: PreferenceName.DEFAULT_PRINTER_NAME,
              value: device.name,
            );
        await ref.read(preferencesProvider.notifier).set(
              key: PreferenceName.DEFAULT_PRINTER_MAC,
              value: device.macAdress,
            );
      },
      dropdownMenuEntries: printers.value!.unwrap().map((info) {
        return DropdownMenuEntry<Device>(
          value: Device.from(info),
          label: info.name,
        );
      }).toList(),
    );
  }
}
