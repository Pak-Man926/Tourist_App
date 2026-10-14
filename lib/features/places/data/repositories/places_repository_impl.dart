import '../../domain/models/place.dart';
import '../../domain/repositories/places_repository.dart';
import '../datasources/local_places_datasource.dart';

class PlacesRepositoryImpl implements PlacesRepository {
  final LocalPlacesDataSource _dataSource;

  PlacesRepositoryImpl({LocalPlacesDataSource? dataSource})
      : _dataSource = dataSource ?? LocalPlacesDataSource();

  @override
  Future<List<Place>> getAllPlaces() => _dataSource.getPlaces();

  @override
  Future<Place?> getPlaceById(String id) => _dataSource.getPlaceById(id);
}
