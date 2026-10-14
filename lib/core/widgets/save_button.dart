import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/saved/presentation/controllers/saved_places_provider.dart';
import '../constants/colors.dart';

class SaveButton extends ConsumerWidget {
  final String placeId;
  final bool overlay;
  final double size;

  const SaveButton({
    super.key,
    required this.placeId,
    this.overlay = false,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedIds = ref.watch(savedPlaceIdsProvider);
    final isSaved = savedIds.contains(placeId);
    final theme = Theme.of(context);

    final bgColor = overlay
        ? Colors.white.withValues(alpha: 0.92)
        : theme.colorScheme.secondary;

    final iconColor = overlay
        ? AppColors.lightPrimary
        : theme.colorScheme.onSurface;

    return Semantics(
      label: isSaved ? 'Unsave place' : 'Save place',
      button: true,
      child: Material(
        color: bgColor,
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            ref.read(savedPlaceIdsProvider.notifier).toggleSave(placeId);
          },
          child: SizedBox(
            width: size,
            height: size,
            child: Center(
              child: Icon(
                isSaved ? Icons.bookmark : Icons.bookmark_border,
                size: size * 0.45,
                color: isSaved ? (overlay ? AppColors.lightPrimary : AppColors.accent) : iconColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
