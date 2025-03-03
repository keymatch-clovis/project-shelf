import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part "preferences.g.dart";

enum PreferenceName {
  DEFAULT_PRINTER_NAME,
  DEFAULT_PRINTER_MAC,
  COMPANY_NAME,
  COMPANY_DOCUMENT,
  COMPANY_EMAIL,
  COMPANY_PHONE,
}

@riverpod
class Preferences extends _$Preferences {
  @override
  FutureOr<Map<PreferenceName, String>> build() {
    return _readPreferences();
  }

  Future<void> setMap(Map<PreferenceName, String> map) async {
    final SharedPreferencesAsync prefs = SharedPreferencesAsync();
    for (final entry in map.entries) {
      await prefs.setString(entry.key.name, entry.value);
    }
    await _invalidate();
  }

  Future<void> set({
    required PreferenceName key,
    required String? value,
  }) async {
    final SharedPreferencesAsync prefs = SharedPreferencesAsync();

    if (value == null) {
      await prefs.remove(key.name);
    } else {
      await prefs.setString(key.name, value);
    }
    await _invalidate();
  }

  Future<Map<PreferenceName, String>> _readPreferences() async {
    final SharedPreferencesAsync prefs = SharedPreferencesAsync();
    final Map<PreferenceName, String> result = {};

    for (final preference in PreferenceName.values) {
      final found = await prefs.getString(preference.name);
      if (found != null) {
        result[preference] = found;
      }
    }

    return result;
  }

  Future<void> _invalidate() async {
    // This will cause "build" on our notifier to asynchronously be called again,
    // and will notify listeners when doing so.
    ref.invalidateSelf();

    // (Optional) We can then wait for the new state to be computed.
    // This ensures "addTodo" does not complete until the new state is available.
    await future;
  }
}
