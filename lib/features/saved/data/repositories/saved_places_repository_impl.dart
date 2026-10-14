import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/repositories/saved_places_repository.dart';

class SavedPlacesRepositoryImpl implements SavedPlacesRepository {
  static const _key = 'karibu-saved';

  @override
  Future<List<String>> getSavedPlaceIds() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key) ?? [];
  }

  @override
  Future<void> savePlaceId(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_key) ?? [];
    if (!list.contains(id)) {
      list.add(id);
      await prefs.setStringList(_key, list);
    }
  }

  @override
  Future<void> removePlaceId(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_key) ?? [];
    if (list.contains(id)) {
      list.remove(id);
      await prefs.setStringList(_key, list);
    }
  }

  @override
  Future<bool> isSaved(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_key) ?? [];
    return list.contains(id);
  }
}
