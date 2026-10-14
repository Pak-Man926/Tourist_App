import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/place.dart';
import '../../domain/repositories/places_repository.dart';
import '../../data/repositories/places_repository_impl.dart';

final placesRepositoryProvider = Provider<PlacesRepository>((ref) {
  return PlacesRepositoryImpl();
});

final allPlacesProvider = FutureProvider<List<Place>>((ref) async {
  final repository = ref.watch(placesRepositoryProvider);
  return await repository.getAllPlaces();
});

final selectedCategoryProvider = StateProvider<String>((ref) => 'all');

final searchQueryProvider = StateProvider<String>((ref) => '');

final topRatedFilterProvider = StateProvider<bool>((ref) => false);

final filteredPlacesProvider = Provider<AsyncValue<List<Place>>>((ref) {
  final allPlacesAsync = ref.watch(allPlacesProvider);
  final category = ref.watch(selectedCategoryProvider);
  final query = ref.watch(searchQueryProvider).trim().toLowerCase();
  final topRated = ref.watch(topRatedFilterProvider);

  return allPlacesAsync.whenData((places) {
    return places.where((place) {
      final matchesCategory = category == 'all' || place.category == category;
      final matchesQuery = query.isEmpty ||
          place.name.toLowerCase().contains(query) ||
          place.area.toLowerCase().contains(query) ||
          place.description.toLowerCase().contains(query);
      final matchesTopRated = !topRated || place.isTopRated;

      return matchesCategory && matchesQuery && matchesTopRated;
    }).toList();
  });
});

final placeByIdProvider = Provider.family<Place?, String>((ref, id) {
  final allPlacesAsync = ref.watch(allPlacesProvider);
  return allPlacesAsync.maybeWhen(
    data: (places) => places.where((p) => p.id == id).firstOrNull,
    orElse: () => null,
  );
});
