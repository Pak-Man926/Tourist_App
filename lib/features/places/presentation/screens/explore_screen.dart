import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/constants/colors.dart';
import '../controllers/places_provider.dart';
import '../widgets/category_pills.dart';
import '../widgets/header_bar.dart';
import '../widgets/hero_banner.dart';
import '../widgets/place_card.dart';

class ExploreScreen extends ConsumerStatefulWidget {
  const ExploreScreen({super.key});

  @override
  ConsumerState<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends ConsumerState<ExploreScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _showFilters = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final searchQuery = ref.watch(searchQueryProvider);
    final topRatedOnly = ref.watch(topRatedFilterProvider);
    final placesAsync = ref.watch(filteredPlacesProvider);

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: RefreshIndicator(
          onRefresh: () async => ref.refresh(allPlacesProvider),
          color: AppColors.lightPrimary,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeaderBar(),

                // Editorial Headline Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 20,
                            height: 1.5,
                            color: AppColors.accent,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'GO SOMEWHERE GOOD',
                            style: GoogleFonts.dmSans(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.5,
                              color: theme.colorScheme.onSurface.withValues(alpha: 0.55),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      RichText(
                        text: TextSpan(
                          text: 'Find your kind\nof ',
                          style: GoogleFonts.gloock(
                            fontSize: 36,
                            height: 1.15,
                            color: theme.colorScheme.onSurface,
                          ),
                          children: [
                            TextSpan(
                              text: 'Nairobi.',
                              style: TextStyle(color: theme.colorScheme.primary),
                            ),
                            const TextSpan(
                              text: ' ✳',
                              style: TextStyle(
                                color: AppColors.accent,
                                fontSize: 26,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'The local favourites. The unexpected finds.',
                        style: GoogleFonts.dmSans(
                          fontSize: 13,
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                        ),
                      ),
                      const SizedBox(height: 18),

                      // Search Bar & Filter Toggle
                      Container(
                        height: 50,
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: theme.colorScheme.outline),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              LucideIcons.search,
                              size: 18,
                              color: theme.colorScheme.onSurface.withValues(alpha: 0.55),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                controller: _searchController,
                                onChanged: (value) {
                                  ref.read(searchQueryProvider.notifier).state =
                                      value;
                                },
                                style: GoogleFonts.dmSans(
                                  fontSize: 13,
                                  color: theme.colorScheme.onSurface,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'What are you in the mood for?',
                                  hintStyle: GoogleFonts.dmSans(
                                    fontSize: 13,
                                    color: theme.colorScheme.onSurface.withValues(alpha: 0.45),
                                  ),
                                  border: InputBorder.none,
                                  isDense: true,
                                ),
                              ),
                            ),
                            if (searchQuery.isNotEmpty)
                              IconButton(
                                icon: const Icon(LucideIcons.x, size: 16),
                                onPressed: () {
                                  _searchController.clear();
                                  ref.read(searchQueryProvider.notifier).state =
                                      '';
                                },
                              ),
                            Container(
                              height: 24,
                              width: 1,
                              color: theme.colorScheme.outline,
                              margin: const EdgeInsets.symmetric(horizontal: 6),
                            ),
                            IconButton(
                              icon: Icon(
                                LucideIcons.slidersHorizontal,
                                size: 17,
                                color: _showFilters || topRatedOnly
                                    ? theme.colorScheme.primary
                                    : theme.colorScheme.onSurface.withValues(alpha: 0.6),
                              ),
                              onPressed: () {
                                setState(() {
                                  _showFilters = !_showFilters;
                                });
                              },
                            ),
                          ],
                        ),
                      ),

                      // Expandable Filter Tray
                      if (_showFilters)
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.secondary,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Row(
                            children: [
                              Checkbox(
                                value: topRatedOnly,
                                activeColor: theme.colorScheme.primary,
                                onChanged: (val) {
                                  ref.read(topRatedFilterProvider.notifier).state =
                                      val ?? false;
                                },
                              ),
                              Text(
                                'Only top-rated places (4.8+)',
                                style: GoogleFonts.dmSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: theme.colorScheme.onSurface,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Category Chips
                const CategoryPills(),

                const SizedBox(height: 20),

                // Hero Spotlight Banner (shown on "all" category without search)
                if (selectedCategory == 'all' && searchQuery.isEmpty) ...[
                  const HeroBanner(),
                  const SizedBox(height: 24),
                ],

                // Places List Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            selectedCategory == 'all'
                                ? 'Good places, close by'
                                : _getCategoryTitle(selectedCategory),
                            style: GoogleFonts.gloock(
                              fontSize: 22,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'A few favourites to get you started',
                            style: GoogleFonts.dmSans(
                              fontSize: 11,
                              color: theme.colorScheme.onSurface.withValues(alpha: 0.55),
                            ),
                          ),
                        ],
                      ),
                      TextButton.icon(
                        onPressed: () => context.push('/map'),
                        icon: const Icon(LucideIcons.map, size: 14),
                        label: Text(
                          'Map',
                          style: GoogleFonts.dmSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 14),

                // Horizontal Place Cards
                placesAsync.when(
                  data: (places) {
                    if (places.isEmpty) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.secondary,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Text(
                            'No places found. Try a different search or filter.',
                            style: GoogleFonts.dmSans(
                              fontSize: 13,
                              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                            ),
                          ),
                        ),
                      );
                    }

                    return SizedBox(
                      height: 275,
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        scrollDirection: Axis.horizontal,
                        itemCount: places.length,
                        separatorBuilder: (_, _) => const SizedBox(width: 14),
                        itemBuilder: (context, index) {
                          return PlaceCard(place: places[index]);
                        },
                      ),
                    );
                  },
                  loading: () => const Center(
                    child: Padding(
                      padding: EdgeInsets.all(32),
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                  error: (err, _) => Center(
                    child: Text('Error loading spots: $err'),
                  ),
                ),

                const SizedBox(height: 20),

                // Inspiring Story Promo Card
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: theme.colorScheme.outline),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.secondary,
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Icon(
                            LucideIcons.compass,
                            size: 22,
                            color: AppColors.accent,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Less scrolling. More stories.',
                              style: GoogleFonts.gloock(
                                fontSize: 17,
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              'Pick a place. Make the day your own.',
                              style: GoogleFonts.dmSans(
                                fontSize: 11,
                                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                Center(
                  child: Text(
                    'WITH LOVE, FROM NAIROBI',
                    style: GoogleFonts.dmSans(
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getCategoryTitle(String id) {
    switch (id) {
      case 'food':
        return 'Food & Dining';
      case 'nightlife':
        return 'Nightlife & Drinks';
      case 'activities':
        return 'Activities & Trails';
      case 'sights':
        return 'Sights & Landmarks';
      default:
        return 'Curated for you';
    }
  }
}
