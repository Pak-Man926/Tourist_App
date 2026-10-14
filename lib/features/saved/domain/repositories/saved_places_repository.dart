abstract class SavedPlacesRepository {
  Future<List<String>> getSavedPlaceIds();
  Future<void> savePlaceId(String id);
  Future<void> removePlaceId(String id);
  Future<bool> isSaved(String id);
}
