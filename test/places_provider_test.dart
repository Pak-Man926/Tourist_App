import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tourist_app/features/places/presentation/controllers/places_provider.dart';

void main() {
  group('PlacesProvider & Filters Tests', () {
    test('allPlacesProvider loads preloaded Nairobi places', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final places = await container.read(allPlacesProvider.future);
      expect(places.isNotEmpty, true);
      expect(places.any((p) => p.name == 'Giraffe Centre'), true);
      expect(places.any((p) => p.name == 'The Talisman'), true);
    });

    test('filteredPlacesProvider filters by category correctly', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      // Wait for all places to load
      await container.read(allPlacesProvider.future);

      // Select 'food' category
      container.read(selectedCategoryProvider.notifier).state = 'food';

      final filtered = container.read(filteredPlacesProvider).value!;
      expect(filtered.isNotEmpty, true);
      for (final place in filtered) {
        expect(place.category, 'food');
      }
    });

    test('filteredPlacesProvider filters by search query', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      await container.read(allPlacesProvider.future);

      container.read(searchQueryProvider.notifier).state = 'Talisman';

      final filtered = container.read(filteredPlacesProvider).value!;
      expect(filtered.length, 1);
      expect(filtered.first.name, 'The Talisman');
    });

    test('filteredPlacesProvider filters by top rated flag', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      await container.read(allPlacesProvider.future);

      container.read(topRatedFilterProvider.notifier).state = true;

      final filtered = container.read(filteredPlacesProvider).value!;
      for (final place in filtered) {
        expect(double.parse(place.rating) >= 4.8, true);
      }
    });
  });
}
