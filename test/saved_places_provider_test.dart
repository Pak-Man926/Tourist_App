import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tourist_app/features/saved/domain/repositories/saved_places_repository.dart';
import 'package:tourist_app/features/saved/presentation/controllers/saved_places_provider.dart';

class FakeSavedPlacesRepository implements SavedPlacesRepository {
  final List<String> _storage = [];

  @override
  Future<List<String>> getSavedPlaceIds() async => List.unmodifiable(_storage);

  @override
  Future<void> savePlaceId(String id) async {
    if (!_storage.contains(id)) _storage.add(id);
  }

  @override
  Future<void> removePlaceId(String id) async {
    _storage.remove(id);
  }

  @override
  Future<bool> isSaved(String id) async => _storage.contains(id);
}

void main() {
  group('SavedPlacesProvider Tests', () {
    test('toggleSave adds and removes place IDs correctly', () async {
      final fakeRepo = FakeSavedPlacesRepository();
      final container = ProviderContainer(
        overrides: [
          savedPlacesRepositoryProvider.overrideWithValue(fakeRepo),
        ],
      );
      addTearDown(container.dispose);

      // Initially empty
      expect(container.read(savedPlaceIdsProvider), isEmpty);

      // Save 'giraffe'
      await container.read(savedPlaceIdsProvider.notifier).toggleSave('giraffe');
      expect(container.read(savedPlaceIdsProvider), contains('giraffe'));

      // Save 'talisman'
      await container.read(savedPlaceIdsProvider.notifier).toggleSave('talisman');
      expect(container.read(savedPlaceIdsProvider), ['giraffe', 'talisman']);

      // Unsave 'giraffe'
      await container.read(savedPlaceIdsProvider.notifier).toggleSave('giraffe');
      expect(container.read(savedPlaceIdsProvider), ['talisman']);
    });
  });
}
