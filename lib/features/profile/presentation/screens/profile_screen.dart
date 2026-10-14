import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:tourist_app/core/widgets/brand_logo.dart';
import 'package:tourist_app/features/places/presentation/widgets/header_bar.dart';
import 'package:tourist_app/features/saved/presentation/controllers/saved_places_provider.dart';
import '../controllers/theme_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final themeMode = ref.watch(themeModeProvider);
    final isDark = themeMode == ThemeMode.dark;
    final savedIds = ref.watch(savedPlaceIdsProvider);

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 110),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeaderBar(title: 'Your kind of adventure.'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    // Explorer Account Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.secondary,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              color: theme.scaffoldBackgroundColor,
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Icon(
                                LucideIcons.user,
                                size: 30,
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            'Hello, explorer.',
                            style: GoogleFonts.gloock(
                              fontSize: 24,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'A little curiosity is all you need to get started.',
                            style: GoogleFonts.dmSans(
                              fontSize: 12,
                              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 18),
                          ElevatedButton(
                            onPressed: () => context.push('/sign-up'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.colorScheme.primary,
                              foregroundColor: theme.colorScheme.onPrimary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                              elevation: 0,
                            ),
                            child: Text(
                              'Create your account',
                              style: GoogleFonts.dmSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Already part of the journey? ',
                                style: GoogleFonts.dmSans(
                                  fontSize: 12,
                                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => context.push('/sign-in'),
                                child: Text(
                                  'Sign in',
                                  style: GoogleFonts.dmSans(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: theme.colorScheme.onSurface,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    // Section Heading
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'MAKE YOURSELF AT HOME',
                        style: GoogleFonts.dmSans(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.5,
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Menu Options
                    _MenuTile(
                      icon: LucideIcons.bookmark,
                      title: 'Saved places',
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${savedIds.length}',
                            style: GoogleFonts.dmSans(
                              fontSize: 13,
                              color: theme.colorScheme.onSurface.withValues(alpha: 0.55),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Icon(
                            LucideIcons.chevronRight,
                            size: 16,
                            color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                          ),
                        ],
                      ),
                      onTap: () => context.go('/saved'),
                    ),

                    _MenuTile(
                      icon: isDark ? LucideIcons.moon : LucideIcons.sun,
                      title: 'Dark mode',
                      trailing: Switch.adaptive(
                        value: isDark,
                        activeThumbColor: theme.colorScheme.primary,
                        onChanged: (_) {
                          ref.read(themeModeProvider.notifier).toggleTheme();
                        },
                      ),
                      onTap: () {
                        ref.read(themeModeProvider.notifier).toggleTheme();
                      },
                    ),

                    _MenuTile(
                      icon: LucideIcons.mapPin,
                      title: 'Your neighbourhood',
                      trailing: Icon(
                        LucideIcons.chevronRight,
                        size: 16,
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                      ),
                      onTap: () => context.push('/map'),
                    ),

                    _MenuTile(
                      icon: LucideIcons.logOut,
                      title: 'Back to the beginning',
                      trailing: Icon(
                        LucideIcons.chevronRight,
                        size: 16,
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                      ),
                      onTap: () => context.go('/welcome'),
                    ),

                    const SizedBox(height: 40),

                    // Brand Footer
                    const BrandLogo(),
                    const SizedBox(height: 8),
                    Text(
                      'A local lens on a world of possibility.',
                      style: GoogleFonts.dmSans(
                        fontSize: 11,
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Design preview · Nairobi edition',
                      style: GoogleFonts.dmSans(
                        fontSize: 9,
                        letterSpacing: 1,
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                      ),
                    ),
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

class _MenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget trailing;
  final VoidCallback onTap;

  const _MenuTile({
    required this.icon,
    required this.title,
    required this.trailing,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      child: Container(
        height: 58,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: theme.colorScheme.outline),
          ),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: theme.colorScheme.onSurface),
            const SizedBox(width: 14),
            Text(
              title,
              style: GoogleFonts.dmSans(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const Spacer(),
            trailing,
          ],
        ),
      ),
    );
  }
}
