import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:partnest/core/theme/app_colors.dart';
import 'package:partnest/core/theme/app_typography.dart';
import 'package:partnest/core/theme/widgets/custom_button.dart';
import 'package:partnest/core/theme/widgets/custom_input_field.dart';
import 'package:partnest/features/auth/presentation/pages/login_page.dart';
import 'package:partnest/features/auth/presentation/pages/onboarding/welcome_role_selection_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  // Password Strength
  double _passwordStrength = 0;
  String _passwordStrengthText = 'Weak';
  Color _passwordStrengthColor = AppColors.dangerRed;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _checkPasswordStrength(String value) {
    if (value.isEmpty) {
      setState(() {
        _passwordStrength = 0;
        _passwordStrengthText = 'Too short';
        _passwordStrengthColor = AppColors.dangerRed;
      });
      return;
    }
    
    double strength = 0;
    if (value.length >= 8) strength += 0.25;
    if (value.contains(RegExp(r'[A-Z]'))) strength += 0.25;
    if (value.contains(RegExp(r'[0-9]'))) strength += 0.25;
    if (value.contains(RegExp(r'[!@#\$&*~]'))) strength += 0.25;

    setState(() {
      _passwordStrength = strength;
      if (strength <= 0.25) {
        _passwordStrengthText = 'Weak';
        _passwordStrengthColor = AppColors.dangerRed;
      } else if (strength <= 0.5) {
        _passwordStrengthText = 'Fair';
        _passwordStrengthColor = AppColors.warningAmber;
      } else if (strength <= 0.75) {
        _passwordStrengthText = 'Good';
        _passwordStrengthColor = AppColors.trustBlue;
      } else {
        _passwordStrengthText = 'Strong';
        _passwordStrengthColor = AppColors.successGreen;
      }
    });
  }

  void _handleSignUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      if (!mounted) return;
      setState(() => _isLoading = false);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const WelcomeRoleSelectionPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutralWhite,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(LucideIcons.chevronLeft, color: AppColors.slate900),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginPage()),
                      );
                    },
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Create Account',
                        style: AppTypography.textTheme.headlineMedium,
                      ),
                    ),
                  ),
                  const SizedBox(width: 48), // Balance for back button
                ],
              ),
            ),
            
            // Body
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 8),
                      Text(
                        'Join Partnex to unlock funding opportunities',
                        textAlign: TextAlign.center,
                        style: AppTypography.textTheme.bodyMedium?.copyWith(
                          color: AppColors.slate600,
                        ),
                      ),
                      const SizedBox(height: 24),
                      
                      CustomInputField(
                        label: 'Full Name',
                        placeholder: 'John Doe',
                        controller: _nameController,
                        validator: (value) {
                          if (value == null || value.trim().length < 2) {
                            return 'Please enter your full name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      
                      CustomInputField(
                        label: 'Email Address',
                        placeholder: 'you@example.com',
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a valid email address';
                          }
                          final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                          if (!emailRegExp.hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      
                      CustomInputField(
                        label: 'Password',
                        placeholder: '········',
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        onChanged: _checkPasswordStrength,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword ? LucideIcons.eyeOff : LucideIcons.eye,
                            color: AppColors.slate400,
                            size: 20,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                        validator: (value) {
                          if (value == null || _passwordStrength < 0.75) {
                            return 'Password must be at least 8 characters with 1 uppercase letter and 1 number';
                          }
                          return null;
                        },
                      ),
                      
                      const SizedBox(height: 8),
                      // Password Strength Indicator
                      Row(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(2),
                              child: LinearProgressIndicator(
                                value: _passwordStrength,
                                backgroundColor: AppColors.slate200,
                                color: _passwordStrengthColor,
                                minHeight: 4,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _passwordStrengthText,
                            style: AppTypography.textTheme.bodySmall?.copyWith(
                              color: _passwordStrengthColor,
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 16),

                      CustomInputField(
                        label: 'Confirm Password',
                        placeholder: '········',
                        controller: _confirmPasswordController,
                        obscureText: _obscureConfirmPassword,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirmPassword ? LucideIcons.eyeOff : LucideIcons.eye,
                            color: AppColors.slate400,
                            size: 20,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureConfirmPassword = !_obscureConfirmPassword;
                            });
                          },
                        ),
                        validator: (value) {
                          if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 24),
                      
                      CustomButton(
                        text: 'Create Account',
                        onPressed: _handleSignUp,
                        isLoading: _isLoading,
                        // Terms are assumed accepted by clicking the button in this flow now
                      ),
                      
                      const SizedBox(height: 16),
                      
                      CustomButton(
                        text: 'Already have an account? Sign in',
                        variant: ButtonVariant.tertiary,
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => const LoginPage()),
                          );
                        },
                      ),
                      
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
            
            // Shared Footer matching WelcomeRoleSelectionPage
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0, top: 16.0),
              child: Text.rich(
                TextSpan(
                  text: 'By continuing, you agree to our ',
                  style: AppTypography.textTheme.bodySmall?.copyWith(
                    color: AppColors.slate600,
                  ),
                  children: [
                    TextSpan(
                      text: 'Terms of Service',
                      style: AppTypography.textTheme.bodySmall?.copyWith(
                        color: AppColors.trustBlue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const TextSpan(text: ' and '),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: AppTypography.textTheme.bodySmall?.copyWith(
                        color: AppColors.trustBlue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
