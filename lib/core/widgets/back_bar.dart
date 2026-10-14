import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../constants/typography.dart';

class BackBar extends StatelessWidget {
  final String title;
  final VoidCallback? onBack;

  const BackBar({
    super.key,
    required this.title,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          Material(
            color: Colors.transparent,
            shape: CircleBorder(
              side: BorderSide(
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: onBack ??
                  () {
                    if (context.canPop()) {
                      context.pop();
                    } else {
                      context.go('/explore');
                    }
                  },
              child: const SizedBox(
                width: 44,
                height: 44,
                child: Center(
                  child: Icon(LucideIcons.arrowLeft, size: 20),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: AppTypography.titleMedium(
                color: Theme.of(context).colorScheme.onSurface,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
