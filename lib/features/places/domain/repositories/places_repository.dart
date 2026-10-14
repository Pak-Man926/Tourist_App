import '../models/place.dart';

abstract class PlacesRepository {
  Future<List<Place>> getAllPlaces();
  Future<Place?> getPlaceById(String id);
}
