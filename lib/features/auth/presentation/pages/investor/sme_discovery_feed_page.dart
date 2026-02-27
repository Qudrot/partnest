import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:partnex/core/theme/app_colors.dart';
import 'package:partnex/core/theme/app_typography.dart';
import 'package:partnex/core/theme/widgets/partnex_logo.dart';
import 'package:partnex/features/auth/presentation/pages/investor/sme_profile_expanded_page.dart';
import 'package:partnex/features/auth/presentation/pages/investor/deep_dive_evidence_page.dart';
import 'package:partnex/features/auth/presentation/blocs/discovery_cubit/discovery_cubit.dart';
import 'package:partnex/features/auth/presentation/blocs/discovery_cubit/discovery_state.dart';
import 'package:partnex/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:partnex/features/auth/presentation/blocs/auth_state.dart';
import 'package:partnex/features/auth/presentation/blocs/auth_event.dart';
import 'package:partnex/features/auth/presentation/pages/login_page.dart';

class SmeDiscoveryFeedPage extends StatefulWidget {
  const SmeDiscoveryFeedPage({super.key});

  @override
  State<SmeDiscoveryFeedPage> createState() => _SmeDiscoveryFeedPageState();
}

class _SmeDiscoveryFeedPageState extends State<SmeDiscoveryFeedPage> {
  final List<String> _activeFilters = ['Score: 80+', 'Revenue: ₦500K+'];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DiscoveryCubit>().loadSmes();
    });
  }

  void _navigateToProfile(SmeCardData sme) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => SmeProfileExpandedPage(sme: sme)),
    );
  }

  void _navigateToEvidence() {
     Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const DeepDiveEvidencePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.slate50,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthUnauthenticated) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const LoginPage()),
              (route) => false,
            );
          }
        },
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              _buildFilterBar(),
            Expanded(
              child: BlocBuilder<DiscoveryCubit, DiscoveryState>(
                builder: (context, state) {
                  if (state is DiscoveryLoading || state is DiscoveryInitial) {
                    return const Center(child: CircularProgressIndicator(color: AppColors.trustBlue));
                  } else if (state is DiscoveryError) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          state.message,
                          style: AppTypography.textTheme.bodyMedium?.copyWith(
                            color: AppColors.dangerRed,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  } else if (state is DiscoveryLoaded) {
                    final smes = state.smes.map((map) => SmeCardData.fromMap(map)).toList();
                    
                    if (smes.isEmpty) {
                       return Center(
                         child: Text(
                           'No SMEs found matching your criteria.',
                           style: AppTypography.textTheme.bodyMedium?.copyWith(color: AppColors.slate600),
                         ),
                       );
                    }

                    return ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                      itemCount: smes.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        return _buildSmeCard(smes[index]);
                      },
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Row(
        children: [
          const PartnexLogo(size: 32, variant: PartnexLogoVariant.iconOnly),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.slate100,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: AppColors.slate200),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: [
                  const Icon(LucideIcons.search, size: 16, color: AppColors.slate400),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search by company name, industry, or location...',
                        hintStyle: AppTypography.textTheme.bodyMedium?.copyWith(
                          color: AppColors.slate400,
                          fontSize: 14,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.only(bottom: 14),
                      ),
                      style: AppTypography.textTheme.bodyMedium?.copyWith(
                        color: AppColors.slate700,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // The sliders icon was removed from here
          const SizedBox(width: 8),
          Material(
            color: Colors.transparent,
            child: PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'logout') {
                  _showLogoutConfirmation();
                }
              },
              icon: const Icon(LucideIcons.menu, size: 24, color: AppColors.slate900),
              position: PopupMenuPosition.under,
              color: Colors.white,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: const BorderSide(color: AppColors.slate200),
              ),
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'profile',
                  child: Text('My Profile', style: AppTypography.textTheme.bodyMedium?.copyWith(color: AppColors.slate900)),
                ),
                PopupMenuItem<String>(
                  value: 'settings',
                  child: Text('Settings', style: AppTypography.textTheme.bodyMedium?.copyWith(color: AppColors.slate900)),
                ),
                const PopupMenuDivider(height: 1),
                PopupMenuItem<String>(
                  value: 'logout',
                  child: Text(
                    'Log Out', 
                    style: AppTypography.textTheme.bodyMedium?.copyWith(color: AppColors.dangerRed, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text(
          'Log Out',
          style: AppTypography.textTheme.headlineSmall?.copyWith(color: AppColors.slate900, fontWeight: FontWeight.w700),
        ),
        content: Text(
          'Are you sure you want to end your session?',
          style: AppTypography.textTheme.bodyMedium?.copyWith(color: AppColors.slate600),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: AppTypography.textTheme.labelLarge?.copyWith(color: AppColors.slate600, fontWeight: FontWeight.w600),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // close dialog
              context.read<AuthBloc>().add(LogoutEvent()); // Trigger logout
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.dangerRed,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            ),
            child: Text(
              'Log Out',
              style: AppTypography.textTheme.labelLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: AppColors.slate200)),
      ),
      child: Row(
        children: [
          // Filter Icon Button
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(6),
              hoverColor: AppColors.slate50,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.slate300),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    const Icon(LucideIcons.filter, size: 14, color: AppColors.slate700),
                    const SizedBox(width: 6),
                    Text(
                      'Filters',
                      style: AppTypography.textTheme.labelMedium?.copyWith(
                        color: AppColors.slate700,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Active Filters Scrollable List
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _activeFilters.map((filter) {
                  return Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.trustBlue.withValues(alpha: 0.1),
                      border: Border.all(color: AppColors.trustBlue.withValues(alpha: 0.3)),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          filter,
                          style: AppTypography.textTheme.labelSmall?.copyWith(
                            color: AppColors.trustBlue,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 4),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _activeFilters.remove(filter);
                            });
                          },
                          child: const Icon(LucideIcons.x, size: 14, color: AppColors.trustBlue),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmeCard(SmeCardData sme) {
    return Container(
      // Removed fixed 64px height to prevent vertical overflow
      constraints: const BoxConstraints(minHeight: 64),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.slate200),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.05),
            blurRadius: 2,
            offset: Offset(0, 1),
          )
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _navigateToProfile(sme),
          borderRadius: BorderRadius.circular(8),
          hoverColor: AppColors.slate50,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Left Section (Business Information) ~60%
                Expanded(
                  flex: 60,
                  child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     mainAxisAlignment: MainAxisAlignment.center,
                     mainAxisSize: MainAxisSize.min, // Let column fit content
                     children: [
                       Text(
                         sme.companyName,
                         style: AppTypography.textTheme.bodyMedium?.copyWith(
                           fontWeight: FontWeight.w600,
                           fontSize: 16,
                           color: AppColors.slate900,
                         ),
                       ),
                       const SizedBox(height: 4),
                       Row(
                         children: [
                            Text(
                              '${sme.industry} · ',
                              style: AppTypography.textTheme.bodySmall?.copyWith(
                                color: AppColors.slate600,
                                fontSize: 12,
                              ),
                            ),
                            const Icon(LucideIcons.mapPin, size: 12, color: AppColors.slate400),
                            const SizedBox(width: 2),
                            Expanded(
                              child: Text(
                                sme.location,
                                style: AppTypography.textTheme.bodySmall?.copyWith(
                                  color: AppColors.slate600,
                                  fontSize: 12,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                         ],
                       ),
                       const SizedBox(height: 4),
                       Text(
                         sme.growthSignal,
                         style: AppTypography.textTheme.bodyMedium?.copyWith(
                           fontWeight: FontWeight.w600,
                           fontSize: 12,
                           color: sme.isGrowthPositive ? AppColors.successGreen : AppColors.dangerRed,
                         ),
                       ),
                     ],
                  ),
                ),
                // Center Section (Empty to maintain structure or can be removed if strictly 2 columns now)
                Expanded(
                  flex: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Stat moved to title row, keeping this flex empty to push score to the right
                      // or we could place revenue here if requested.
                    ],
                  ),
                ),
                // Right Section (Score Badge) ~10%
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: _navigateToEvidence,
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: sme.scoreColor,
                      shape: BoxShape.circle,
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.05),
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        )
                      ],
                    ),
                    child: Center(
                      child: Text(
                        '${sme.score}',
                        style: AppTypography.textTheme.headlineSmall?.copyWith(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
                // Note: risk label is hidden on mobile per spec 
                // to maintain strict 64px height and density.
              ],
            ),
          ),
        ),
      ),
    );
  }
}
