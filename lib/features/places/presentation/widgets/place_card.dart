import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tourist_app/core/constants/colors.dart';
import 'package:tourist_app/core/widgets/save_button.dart';
import 'package:tourist_app/features/places/domain/models/place.dart';

class PlaceCard extends StatelessWidget {
  final Place place;
  final double width;

  const PlaceCard({
    super.key,
    required this.place,
    this.width = 235,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: width,
      child: InkWell(
        onTap: () => context.push('/place/${place.id}'),
        borderRadius: BorderRadius.circular(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with overlays
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: [
                  SizedBox(
                    height: 190,
                    width: width,
                    child: CachedNetworkImage(
                      imageUrl: place.photo,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: theme.colorScheme.secondary,
                        child: const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: theme.colorScheme.secondary,
                        child: const Icon(Icons.broken_image, size: 36),
                      ),
                    ),
                  ),

                  // Top right bookmark save button
                  Positioned(
                    top: 10,
                    right: 10,
                    child: SaveButton(
                      placeId: place.id,
                      overlay: true,
                      size: 38,
                    ),
                  ),

                  // Bottom left badge
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.95),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        place.category == 'activities'
                            ? 'WORTH THE DETOUR'
                            : 'LOCAL FAVOURITE',
                        style: GoogleFonts.dmSans(
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                          color: AppColors.lightPrimary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Place Name and Rating
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    place.name,
                    style: GoogleFonts.dmSans(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: theme.colorScheme.onSurface,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 6),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.star,
                      size: 13,
                      color: AppColors.starFilled,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      place.rating,
                      style: GoogleFonts.dmSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 3),

            // Area and Distance
            Text(
              '${place.area} · ${place.distance} away',
              style: GoogleFonts.dmSans(
                fontSize: 11,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.55),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
