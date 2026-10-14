import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/typography.dart';
import '../../../../core/utils/url_launcher_helper.dart';
import '../../../../core/widgets/back_bar.dart';
import '../../../../core/widgets/save_button.dart';
import '../../domain/models/place.dart';
import '../controllers/places_provider.dart';

class PlaceDetailScreen extends ConsumerStatefulWidget {
  final String id;

  const PlaceDetailScreen({super.key, required this.id});

  @override
  ConsumerState<PlaceDetailScreen> createState() => _PlaceDetailScreenState();
}

class _PlaceDetailScreenState extends ConsumerState<PlaceDetailScreen> {
  int _currentSlide = 0;
  late PageController _pageController;
  Timer? _carouselTimer;
  String _activeTab = 'About';
  bool _showVisitInfo = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _carouselTimer?.cancel();
    _carouselTimer = Timer.periodic(const Duration(milliseconds: 5500), (timer) {
      if (!mounted) return;
      final place = ref.read(placeByIdProvider(widget.id));
      if (place == null || place.gallery.isEmpty) return;

      final nextPage = (_currentSlide + 1) % place.gallery.length;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _carouselTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _openFullscreenGallery(Place place) {
    _carouselTimer?.cancel();
    showDialog(
      context: context,
      barrierColor: Colors.black,
      builder: (context) {
        return _FullscreenGalleryDialog(
          gallery: place.gallery,
          initialIndex: _currentSlide,
        );
      },
    ).then((_) {
      if (mounted) _startAutoSlide();
    });
  }

  @override
  Widget build(BuildContext context) {
    final place = ref.watch(placeByIdProvider(widget.id));
    final theme = Theme.of(context);

    if (place == null) {
      return Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BackBar(title: 'Place not found'),
              Padding(
                padding: const EdgeInsets.all(24),
                child: TextButton(
                  onPressed: () => context.go('/explore'),
                  child: const Text('Return to Explore'),
                ),
              ),
            ],
          ),
        ),
      );
    }

    final tabs = [
      'About',
      if (place.category == 'food') 'Menu',
      'Reviews',
    ];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BackBar(
                title: place.category == 'food'
                    ? 'A local food favourite'
                    : 'A little discovery',
              ),

              // Image Carousel
              SizedBox(
                height: 320,
                child: Stack(
                  children: [
                    PageView.builder(
                      controller: _pageController,
                      itemCount: place.gallery.length,
                      onPageChanged: (index) {
                        setState(() {
                          _currentSlide = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => _openFullscreenGallery(place),
                          child: CachedNetworkImage(
                            imageUrl: place.gallery[index],
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              color: theme.colorScheme.secondary,
                              child: const Center(
                                child: CircularProgressIndicator(strokeWidth: 2),
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              color: theme.colorScheme.secondary,
                              child: const Icon(Icons.broken_image, size: 40),
                            ),
                          ),
                        );
                      },
                    ),

                    // Top-right Save Bookmark Button
                    Positioned(
                      top: 14,
                      right: 18,
                      child: SaveButton(
                        placeId: place.id,
                        overlay: true,
                        size: 42,
                      ),
                    ),

                    // Bottom navigation controls & indicator pills
                    Positioned(
                      bottom: 14,
                      left: 18,
                      right: 18,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Previous Button
                          _CircleButton(
                            icon: LucideIcons.chevronLeft,
                            onTap: () {
                              final prev = (_currentSlide - 1 + place.gallery.length) %
                                  place.gallery.length;
                              _pageController.animateToPage(
                                prev,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                          ),

                          // Indicator Dots
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(place.gallery.length, (i) {
                              final isActive = _currentSlide == i;
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 250),
                                margin: const EdgeInsets.symmetric(horizontal: 3),
                                width: isActive ? 24 : 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: isActive
                                      ? Colors.white
                                      : Colors.white.withValues(alpha: 0.5),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              );
                            }),
                          ),

                          // Expand Button
                          _CircleButton(
                            icon: LucideIcons.expand,
                            onTap: () => _openFullscreenGallery(place),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Details Body
              Padding(
                padding: const EdgeInsets.all(22.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      place.label.toUpperCase(),
                      style: GoogleFonts.dmSans(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.8,
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.55),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      place.name,
                      style: AppTypography.displayMedium(
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Rating and Reviews Row
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          size: 14,
                          color: AppColors.starFilled,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          place.rating,
                          style: GoogleFonts.dmSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '${place.reviews} reviews · ${place.area}',
                          style: GoogleFonts.dmSans(
                            fontSize: 12,
                            color: theme.colorScheme.onSurface.withValues(alpha: 0.55),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Segmented Tabs
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: theme.colorScheme.outline,
                          ),
                        ),
                      ),
                      child: Row(
                        children: tabs.map((tab) {
                          final isSelected = _activeTab == tab;
                          return InkWell(
                            onTap: () {
                              setState(() {
                                _activeTab = tab;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.only(
                                  right: 24, bottom: 12, top: 4),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: isSelected
                                        ? theme.colorScheme.primary
                                        : Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                              ),
                              child: Text(
                                tab,
                                style: GoogleFonts.dmSans(
                                  fontSize: 13,
                                  fontWeight: isSelected
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                                  color: isSelected
                                      ? theme.colorScheme.primary
                                      : theme.colorScheme.onSurface.withValues(alpha: 0.55),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                    const SizedBox(height: 18),

                    // Tab Content
                    if (_activeTab == 'About') ...[
                      Text(
                        place.description,
                        style: GoogleFonts.dmSans(
                          fontSize: 14,
                          height: 1.7,
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.75),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // "Plan your visit" Box
                      Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.secondary,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'PLAN YOUR VISIT',
                              style: GoogleFonts.dmSans(
                                fontSize: 9,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.5,
                                color: theme.colorScheme.onSurface.withValues(alpha: 0.55),
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              place.hours,
                              style: GoogleFonts.dmSans(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 14),
                            Text(
                              place.category == 'food' || place.category == 'nightlife'
                                  ? 'ESTIMATED SPEND PER PERSON'
                                  : 'ESTIMATED ENTRY',
                              style: GoogleFonts.dmSans(
                                fontSize: 9,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.5,
                                color: theme.colorScheme.onSurface.withValues(alpha: 0.55),
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              place.price,
                              style: GoogleFonts.dmSans(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 14),
                            Text(
                              place.booking,
                              style: GoogleFonts.dmSans(
                                fontSize: 12,
                                height: 1.5,
                                color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ] else if (_activeTab == 'Menu') ...[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Illustrative menu · confirm with the restaurant',
                            style: GoogleFonts.dmSans(
                              fontSize: 12,
                              color: theme.colorScheme.onSurface.withValues(alpha: 0.55),
                            ),
                          ),
                          const SizedBox(height: 12),
                          ...place.menu.map((item) {
                            return Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: theme.colorScheme.outline,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    item.name,
                                    style: GoogleFonts.dmSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: theme.colorScheme.onSurface,
                                    ),
                                  ),
                                  Text(
                                    item.price,
                                    style: GoogleFonts.dmSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: theme.colorScheme.onSurface,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ],
                      ),
                    ] else ...[
                      Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.secondary,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sample traveller review',
                              style: GoogleFonts.dmSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              place.reviewsList.isNotEmpty
                                  ? place.reviewsList.first.text
                                  : '“A beautiful way to spend an afternoon in Nairobi. Go early, take your time, and bring your camera.”',
                              style: GoogleFonts.dmSans(
                                fontSize: 13,
                                height: 1.6,
                                color: theme.colorScheme.onSurface.withValues(alpha: 0.75),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Demo review · not a live review feed',
                              style: GoogleFonts.dmSans(
                                fontSize: 10,
                                color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],

                    const SizedBox(height: 24),

                    // Action Buttons Row
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 48,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                UrlLauncherHelper.openMapDirections(place.name);
                              },
                              icon: const Icon(LucideIcons.mapPin, size: 16),
                              label: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Get directions',
                                    style: GoogleFonts.dmSans(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  const Icon(LucideIcons.arrowUpRight, size: 14),
                                ],
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme.colorScheme.primary,
                                foregroundColor: theme.colorScheme.onPrimary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                elevation: 0,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        OutlinedButton(
                          onPressed: () {
                            setState(() {
                              _showVisitInfo = !_showVisitInfo;
                            });
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: theme.colorScheme.outline),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            minimumSize: const Size(90, 48),
                          ),
                          child: Text(
                            'Visit info',
                            style: GoogleFonts.dmSans(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                        ),
                      ],
                    ),

                    if (_showVisitInfo) ...[
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.secondary,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Text(
                          '${place.booking} Booking isn’t connected in this preview. Contact the venue directly to confirm your visit.',
                          style: GoogleFonts.dmSans(
                            fontSize: 12,
                            height: 1.5,
                            color: theme.colorScheme.onSurface.withValues(alpha: 0.85),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withValues(alpha: 0.92),
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: 36,
          height: 36,
          child: Center(
            child: Icon(
              icon,
              size: 18,
              color: AppColors.lightPrimary,
            ),
          ),
        ),
      ),
    );
  }
}

class _FullscreenGalleryDialog extends StatefulWidget {
  final List<String> gallery;
  final int initialIndex;

  const _FullscreenGalleryDialog({
    required this.gallery,
    required this.initialIndex,
  });

  @override
  State<_FullscreenGalleryDialog> createState() =>
      _FullscreenGalleryDialogState();
}

class _FullscreenGalleryDialogState extends State<_FullscreenGalleryDialog> {
  late int _currentIndex;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // PageView
            PageView.builder(
              controller: _pageController,
              itemCount: widget.gallery.length,
              onPageChanged: (idx) {
                setState(() {
                  _currentIndex = idx;
                });
              },
              itemBuilder: (context, index) {
                return Center(
                  child: CachedNetworkImage(
                    imageUrl: widget.gallery[index],
                    fit: BoxFit.contain,
                  ),
                );
              },
            ),

            // Close Button
            Positioned(
              top: 16,
              right: 16,
              child: IconButton(
                icon: const Icon(LucideIcons.x, color: Colors.white, size: 28),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),

            // Bottom Arrows & Counter
            Positioned(
              bottom: 24,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(LucideIcons.chevronLeft,
                        color: Colors.white, size: 28),
                    onPressed: () {
                      final prev = (_currentIndex - 1 + widget.gallery.length) %
                          widget.gallery.length;
                      _pageController.animateToPage(
                        prev,
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                  Text(
                    '${_currentIndex + 1} / ${widget.gallery.length}',
                    style: GoogleFonts.dmSans(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(LucideIcons.chevronRight,
                        color: Colors.white, size: 28),
                    onPressed: () {
                      final next = (_currentIndex + 1) % widget.gallery.length;
                      _pageController.animateToPage(
                        next,
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
