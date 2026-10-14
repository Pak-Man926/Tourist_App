import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/typography.dart';
import '../../../../core/widgets/brand_logo.dart';
import '../../../../features/places/data/datasources/local_places_datasource.dart';

enum AuthMode { signIn, signUp, reset }

class AuthScreen extends StatefulWidget {
  final AuthMode mode;

  const AuthScreen({super.key, required this.mode});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _obscurePassword = true;
  bool _isComplete = false;
  String? _noticeMessage;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    setState(() {
      _isComplete = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isSignUp = widget.mode == AuthMode.signUp;
    final isReset = widget.mode == AuthMode.reset;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Bar
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Material(
                      color: Colors.transparent,
                      shape: CircleBorder(
                        side: BorderSide(color: theme.colorScheme.outline),
                      ),
                      child: InkWell(
                        onTap: () {
                          if (isReset) {
                            context.go('/sign-in');
                          } else {
                            context.go('/profile');
                          }
                        },
                        borderRadius: BorderRadius.circular(20),
                        child: const SizedBox(
                          width: 42,
                          height: 42,
                          child: Center(
                            child: Icon(LucideIcons.arrowLeft, size: 19),
                          ),
                        ),
                      ),
                    ),
                    const BrandLogo(),
                    TextButton(
                      onPressed: () => context.go('/explore'),
                      child: Row(
                        children: [
                          Text(
                            'Skip',
                            style: GoogleFonts.dmSans(
                              fontSize: 12,
                              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                            ),
                          ),
                          const SizedBox(width: 2),
                          Icon(
                            LucideIcons.chevronRight,
                            size: 13,
                            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Hero Banner
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                ),
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: CachedNetworkImage(
                        imageUrl: LocalPlacesDataSource.safariPhoto,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.deepForest.withValues(alpha: 0.92),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 14,
                      right: 14,
                      child: Icon(
                        LucideIcons.compass,
                        size: 32,
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                    ),
                    Positioned(
                      bottom: 16,
                      left: 18,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'YOUR NEXT CHAPTER',
                            style: GoogleFonts.dmSans(
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 2,
                              color: AppColors.accent,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'A world of stories.\nA place for yours.',
                            style: GoogleFonts.gloock(
                              fontSize: 22,
                              height: 1.15,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Form / Complete Card
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                child: _isComplete
                    ? _buildSuccessCard(theme, isSignUp, isReset)
                    : _buildForm(theme, isSignUp, isReset),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessCard(ThemeData theme, bool isSignUp, bool isReset) {
    return Container(
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: theme.colorScheme.outline),
      ),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: theme.colorScheme.secondary,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                isReset ? LucideIcons.mail : LucideIcons.check,
                size: 28,
                color: theme.colorScheme.primary,
              ),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'A GLIMPSE OF WHAT’S NEXT',
            style: GoogleFonts.dmSans(
              fontSize: 9,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.5,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            isReset
                ? 'Check your inbox.'
                : isSignUp
                    ? 'Your adventure starts here.'
                    : 'Welcome back, explorer.',
            style: GoogleFonts.gloock(
              fontSize: 26,
              color: theme.colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            isReset
                ? 'In the live app, a reset link would be on its way. No email has been sent in this preview.'
                : 'This is a concept preview only. No account has been created, and you haven’t been signed in. Your details aren’t stored or sent anywhere.',
            style: GoogleFonts.dmSans(
              fontSize: 13,
              height: 1.6,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 22),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                if (isReset) {
                  context.go('/sign-in');
                } else {
                  context.go('/explore');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isReset ? 'Back to sign in' : 'Keep exploring',
                    style: GoogleFonts.dmSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(LucideIcons.arrowRight, size: 16),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () {
              setState(() {
                _isComplete = false;
              });
            },
            child: Text(
              'Back to the form',
              style: GoogleFonts.dmSans(
                fontSize: 12,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm(ThemeData theme, bool isSignUp, bool isReset) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isReset
              ? 'A LITTLE HELP ALONG THE WAY'
              : isSignUp
                  ? 'MAKE YOURSELF AT HOME'
                  : 'GOOD TO HAVE YOU HERE',
          style: GoogleFonts.dmSans(
            fontSize: 9,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.5,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.55),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          isReset
              ? 'Lost your password?'
              : isSignUp
                  ? 'Hello, new explorer.'
                  : 'Welcome back.',
          style: AppTypography.displaySmall(color: theme.colorScheme.onSurface),
        ),
        const SizedBox(height: 6),
        Text(
          isReset
              ? 'It happens. Enter your email and find your way back.'
              : isSignUp
                  ? 'Save your favourites. Find your people. Make it your journey.'
                  : 'Your favourite places and next adventures are waiting.',
          style: GoogleFonts.dmSans(
            fontSize: 12,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.65),
          ),
        ),
        const SizedBox(height: 20),

        // Social Logins (Google & Apple)
        if (!isReset) ...[
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _noticeMessage =
                          'Google sign-in is a visual preview. No account is connected.';
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: theme.colorScheme.outline),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    minimumSize: const Size(0, 48),
                    foregroundColor: theme.colorScheme.onSurface,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'G ',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Google',
                        style: GoogleFonts.dmSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _noticeMessage =
                          'Apple sign-in is a visual preview. No account is connected.';
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: theme.colorScheme.outline),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    minimumSize: const Size(0, 48),
                    foregroundColor: theme.colorScheme.onSurface,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.apple, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        'Apple',
                        style: GoogleFonts.dmSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          if (_noticeMessage != null) ...[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colorScheme.secondary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                _noticeMessage!,
                style: GoogleFonts.dmSans(
                  fontSize: 11,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                ),
              ),
            ),
          ],

          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(child: Divider(color: theme.colorScheme.outline)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  'or continue with email',
                  style: GoogleFonts.dmSans(
                    fontSize: 10,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                ),
              ),
              Expanded(child: Divider(color: theme.colorScheme.outline)),
            ],
          ),
          const SizedBox(height: 18),
        ],

        // Input Fields
        if (isSignUp) ...[
          _buildInputLabel('Your name', theme),
          const SizedBox(height: 6),
          _buildTextField(
            controller: _nameController,
            hint: 'How should we call you?',
            icon: LucideIcons.user,
            theme: theme,
          ),
          const SizedBox(height: 14),
        ],

        _buildInputLabel('Email address', theme),
        const SizedBox(height: 6),
        _buildTextField(
          controller: _emailController,
          hint: 'you@example.com',
          icon: LucideIcons.mail,
          keyboardType: TextInputType.emailAddress,
          theme: theme,
        ),
        const SizedBox(height: 14),

        if (!isReset) ...[
          _buildInputLabel('Password', theme),
          const SizedBox(height: 6),
          _buildTextField(
            controller: _passwordController,
            hint: isSignUp ? 'Create a password' : 'Your password',
            icon: LucideIcons.lockKeyhole,
            obscureText: _obscurePassword,
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? LucideIcons.eye : LucideIcons.eyeOff,
                size: 17,
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
            theme: theme,
          ),
          if (isSignUp) ...[
            const SizedBox(height: 4),
            Text(
              'A little stronger is better. Use at least 8 characters.',
              style: GoogleFonts.dmSans(
                fontSize: 10,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.55),
              ),
            ),
          ],
          if (!isSignUp) ...[
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => context.go('/forgot-password'),
                child: Text(
                  'Forgot password?',
                  style: GoogleFonts.dmSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
            ),
          ],
          const SizedBox(height: 14),
        ],

        // Submit Button
        SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: _handleSubmit,
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: theme.colorScheme.onPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isReset
                      ? 'Preview reset link'
                      : isSignUp
                          ? 'Create account'
                          : 'Sign in',
                  style: GoogleFonts.dmSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Icon(LucideIcons.arrowRight, size: 17),
              ],
            ),
          ),
        ),

        const SizedBox(height: 16),

        // Bottom switch text
        if (!isReset)
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isSignUp ? 'Already an explorer? ' : 'New around here? ',
                  style: GoogleFonts.dmSans(
                    fontSize: 12,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (isSignUp) {
                      context.go('/sign-in');
                    } else {
                      context.go('/sign-up');
                    }
                  },
                  child: Text(
                    isSignUp ? 'Sign in' : 'Create an account',
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
          ),

        const SizedBox(height: 20),

        // Design Preview Disclaimer
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: theme.colorScheme.secondary,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                LucideIcons.lockKeyhole,
                size: 14,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.55),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Design preview only. Use sample details; nothing is sent or stored, and no account is created.',
                  style: GoogleFonts.dmSans(
                    fontSize: 10,
                    height: 1.5,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.65),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInputLabel(String text, ThemeData theme) {
    return Text(
      text,
      style: GoogleFonts.dmSans(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: theme.colorScheme.onSurface,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required ThemeData theme,
    bool obscureText = false,
    Widget? suffixIcon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: theme.colorScheme.outline),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 17,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: obscureText,
              keyboardType: keyboardType,
              style: GoogleFonts.dmSans(
                fontSize: 13,
                color: theme.colorScheme.onSurface,
              ),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: GoogleFonts.dmSans(
                  fontSize: 13,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.45),
                ),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          ?suffixIcon,
        ],
      ),
    );
  }
}
