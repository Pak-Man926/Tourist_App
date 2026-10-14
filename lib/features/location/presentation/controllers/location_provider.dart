import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationNotifier extends StateNotifier<String> {
  static const _key = 'karibu-area';

  LocationNotifier() : super('Karen, Nairobi') {
    _loadArea();
  }

  Future<void> _loadArea() async {
    final prefs = await SharedPreferences.getInstance();
    final savedArea = prefs.getString(_key);
    if (savedArea != null && savedArea.isNotEmpty) {
      state = savedArea;
    }
  }

  Future<void> setArea(String area) async {
    state = area;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, area);
  }
}

final locationProvider = StateNotifierProvider<LocationNotifier, String>((ref) {
  return LocationNotifier();
});
