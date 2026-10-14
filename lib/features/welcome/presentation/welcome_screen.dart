import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/constants/colors.dart';
import '../../../core/widgets/brand_logo.dart';
import '../../location/presentation/controllers/location_provider.dart';
import '../../places/data/datasources/local_places_datasource.dart';

class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({super.key});

  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 16),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final area = ref.watch(locationProvider);

    return Scaffold(
      backgroundColor: AppColors.welcomeBg,
      body: Stack(
        children: [
          // Background photo with gentle drift animation
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _animController,
              builder: (context, child) {
                return Transform.scale(
                  scale: 1.0 + (_animController.value * 0.08),
                  child: CachedNetworkImage(
                    imageUrl: LocalPlacesDataSource.safariPhoto,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        Container(color: AppColors.welcomeBg),
                    errorWidget: (context, url, error) =>
                        Container(color: AppColors.welcomeBg),
                  ),
                );
              },
            ),
          ),

          // Gradient Overlays
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.deepForest.withValues(alpha: 0.35),
                    AppColors.deepForest.withValues(alpha: 0.70),
                    AppColors.deepForest,
                  ],
                  stops: const [0.0, 0.45, 0.85],
                ),
              ),
            ),
          ),

          // Foreground Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const BrandLogo(light: true),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Text(
                          'KENYA · 01',
                          style: GoogleFonts.dmSans(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 2,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  // "YOUR NEXT CHAPTER" pill
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 7),
                    decoration: BoxDecoration(
                      color: AppColors.deepForest.withValues(alpha: 0.65),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.25),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          LucideIcons.mapPin,
                          size: 13,
                          color: AppColors.accent,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'YOUR NEXT CHAPTER',
                          style: GoogleFonts.dmSans(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.5,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Headline
                  RichText(
                    text: TextSpan(
                      text: 'A city.\nA little wild.\n',
                      style: GoogleFonts.gloock(
                        fontSize: 48,
                        fontWeight: FontWeight.w400,
                        height: 1.05,
                        color: Colors.white,
                      ),
                      children: const [
                        TextSpan(
                          text: 'All yours.',
                          style: TextStyle(color: AppColors.accent),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    'Karibu to Nairobi. Where city rhythms meet untamed beauty, and every corner has a story.',
                    style: GoogleFonts.dmSans(
                      fontSize: 14,
                      height: 1.5,
                      color: Colors.white.withValues(alpha: 0.92),
                    ),
                  ),

                  // Local Knowledge card
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      border: Border.symmetric(
                        horizontal: BorderSide(
                          color: Colors.white.withValues(alpha: 0.2),
                        ),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          LucideIcons.leaf,
                          size: 20,
                          color: AppColors.accent,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'A LITTLE LOCAL KNOWLEDGE',
                                style: GoogleFonts.dmSans(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1.5,
                                  color: AppColors.accent,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'A national park on the city’s doorstep. Yes, those really are giraffes with a skyline.',
                                style: GoogleFonts.dmSans(
                                  fontSize: 12,
                                  height: 1.4,
                                  color: Colors.white.withValues(alpha: 0.92),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Explore Nairobi Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () => context.go('/explore'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accent,
                        foregroundColor: AppColors.accentDark,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              'Let’s explore Nairobi',
                              style: GoogleFonts.dmSans(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(LucideIcons.arrowRight, size: 20),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Neighborhood switcher
                  Center(
                    child: TextButton(
                      onPressed: () => context.push('/map?from=welcome'),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            LucideIcons.mapPin,
                            size: 14,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 6),
                          Flexible(
                            child: Text(
                              '$area · Change',
                              style: GoogleFonts.dmSans(
                                fontSize: 12,
                                color: Colors.white.withValues(alpha: 0.95),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(
                            LucideIcons.chevronRight,
                            size: 14,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),

                  Center(
                    child: Text(
                      'CURATED LOCALLY. EXPLORED YOUR WAY.',
                      style: GoogleFonts.dmSans(
                        fontSize: 9,
                        letterSpacing: 1.5,
                        color: Colors.white.withValues(alpha: 0.65),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
