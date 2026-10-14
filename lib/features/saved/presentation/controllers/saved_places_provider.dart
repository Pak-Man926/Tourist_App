import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/repositories/saved_places_repository.dart';
import '../../data/repositories/saved_places_repository_impl.dart';
import '../../../places/domain/models/place.dart';
import '../../../places/presentation/controllers/places_provider.dart';

final savedPlacesRepositoryProvider = Provider<SavedPlacesRepository>((ref) {
  return SavedPlacesRepositoryImpl();
});

class SavedPlacesNotifier extends StateNotifier<List<String>> {
  final SavedPlacesRepository _repository;

  SavedPlacesNotifier(this._repository) : super([]) {
    _loadSaved();
  }

  Future<void> _loadSaved() async {
    final list = await _repository.getSavedPlaceIds();
    state = list;
  }

  Future<void> toggleSave(String id) async {
    final isAlreadySaved = state.contains(id);
    if (isAlreadySaved) {
      await _repository.removePlaceId(id);
      state = state.where((item) => item != id).toList();
    } else {
      await _repository.savePlaceId(id);
      state = [...state, id];
    }
  }

  bool isSaved(String id) => state.contains(id);
}

final savedPlaceIdsProvider =
    StateNotifierProvider<SavedPlacesNotifier, List<String>>((ref) {
  final repo = ref.watch(savedPlacesRepositoryProvider);
  return SavedPlacesNotifier(repo);
});

final savedPlacesListProvider = Provider<List<Place>>((ref) {
  final savedIds = ref.watch(savedPlaceIdsProvider);
  final allPlacesAsync = ref.watch(allPlacesProvider);

  return allPlacesAsync.maybeWhen(
    data: (places) => places.where((place) => savedIds.contains(place.id)).toList(),
    orElse: () => [],
  );
});
