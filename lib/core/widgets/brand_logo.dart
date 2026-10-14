import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../constants/colors.dart';

class BrandLogo extends StatelessWidget {
  final bool light;
  final double fontSize;
  final double iconSize;

  const BrandLogo({
    super.key,
    this.light = false,
    this.fontSize = 26,
    this.iconSize = 25,
  });

  @override
  Widget build(BuildContext context) {
    final defaultColor = light
        ? Colors.white
        : Theme.of(context).colorScheme.onSurface;

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          LucideIcons.compass,
          size: iconSize,
          color: defaultColor,
        ),
        const SizedBox(width: 6),
        RichText(
          text: TextSpan(
            text: 'karibu',
            style: GoogleFonts.gloock(
              fontSize: fontSize,
              fontWeight: FontWeight.w400,
              color: defaultColor,
            ),
            children: const [
              TextSpan(
                text: '.',
                style: TextStyle(
                  color: AppColors.accent,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
