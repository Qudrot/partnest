import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:partnest/core/theme/app_colors.dart';
import 'package:partnest/core/theme/app_typography.dart';
import 'package:partnest/features/auth/presentation/pages/investor/sme_profile_expanded_page.dart';

class SmeDiscoveryFeedPage extends StatefulWidget {
  const SmeDiscoveryFeedPage({super.key});

  @override
  State<SmeDiscoveryFeedPage> createState() => _SmeDiscoveryFeedPageState();
}

class _SmeDiscoveryFeedPageState extends State<SmeDiscoveryFeedPage> {
  final List<String> _activeFilters = ['Manufacturing', 'Score: 80+', 'Lagos'];

  void _navigateToProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SmeProfileExpandedPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.slate50,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildFilterBar(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                children: [
                  _buildSmeCard(
                    companyName: 'Acme Manufacturing',
                    industry: 'Manufacturing',
                    location: 'Lagos, Nigeria',
                    years: '5 years',
                    score: 85,
                    scoreColor: AppColors.successGreen,
                    riskLevel: 'Low Risk',
                    traction: '↑ 22% YoY',
                    tractionColor: AppColors.successGreen,
                    revenue: '₦750K',
                    employees: '25',
                    liabilities: '₦200K',
                    trustFunded: true,
                    trustPayments: true,
                    trustStability: true,
                  ),
                  _buildSmeCard(
                    companyName: 'TechStart Solutions',
                    industry: 'Technology',
                    location: 'Abuja, Nigeria',
                    years: '2 years',
                    score: 62,
                    scoreColor: AppColors.warningAmber,
                    riskLevel: 'Medium Risk',
                    traction: '↑ 45% YoY',
                    tractionColor: AppColors.successGreen,
                    revenue: '₦500K',
                    employees: '12',
                    liabilities: '₦150K',
                    trustFunded: true,
                    trustPayments: true,
                    trustStability: false,
                  ),
                  _buildSmeCard(
                    companyName: 'Traditional Retail Ltd',
                    industry: 'Retail',
                    location: 'Kano, Nigeria',
                    years: '8 years',
                    score: 45,
                    scoreColor: AppColors.dangerRed,
                    riskLevel: 'High Risk',
                    traction: '↓ 5% YoY',
                    tractionColor: AppColors.dangerRed,
                    revenue: '₦300K',
                    employees: '8',
                    liabilities: '₦400K',
                    trustFunded: false,
                    trustPayments: false,
                    trustStability: false,
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(LucideIcons.chevronDown, size: 16, color: AppColors.slate600),
                      label: Text(
                        'Load More SMEs',
                        style: AppTypography.textTheme.labelLarge?.copyWith(
                          color: AppColors.slate600,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(color: AppColors.slate200),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          const Icon(LucideIcons.hexagon, color: AppColors.trustBlue, size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.slate100,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: AppColors.slate200),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 12),
                  const Icon(LucideIcons.search, size: 16, color: AppColors.slate400),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search by company name, industry...',
                        hintStyle: AppTypography.textTheme.bodyMedium?.copyWith(
                          color: AppColors.slate400,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.only(bottom: 12),
                      ),
                      style: AppTypography.textTheme.bodyMedium?.copyWith(
                        color: AppColors.slate900,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Icon(LucideIcons.sliders, size: 20, color: AppColors.slate600),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar() {
    return Container(
      height: 48,
      color: Colors.white,
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: [
            ..._activeFilters.map((filter) {
              return Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.trustBlue.withValues(alpha: 0.1),
                  border: Border.all(color: AppColors.trustBlue),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    Text(
                      filter,
                      style: AppTypography.textTheme.labelSmall?.copyWith(
                        color: AppColors.trustBlue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 6),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _activeFilters.remove(filter);
                        });
                      },
                      child: const Icon(LucideIcons.x, size: 12, color: AppColors.slate600),
                    ),
                  ],
                ),
              );
            }),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(LucideIcons.plus, size: 14, color: AppColors.trustBlue),
              label: Text(
                'Add Filter',
                style: AppTypography.textTheme.labelSmall?.copyWith(
                  color: AppColors.trustBlue,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSmeCard({
    required String companyName,
    required String industry,
    required String location,
    required String years,
    required int score,
    required Color scoreColor,
    required String riskLevel,
    required String traction,
    required Color tractionColor,
    required String revenue,
    required String employees,
    required String liabilities,
    required bool trustFunded,
    required bool trustPayments,
    required bool trustStability,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.slate200),
        boxShadow: [
          BoxShadow(
            color: AppColors.slate200.withValues(alpha: 0.5),
            blurRadius: 4,
            offset: const Offset(0, 1),
          )
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _navigateToProfile,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left Section (40%)
                Expanded(
                  flex: 40,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: AppColors.slate100,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Icon(LucideIcons.building, size: 16, color: AppColors.slate400),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              companyName,
                              style: AppTypography.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColors.slate900,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        '$industry · $location',
                        style: AppTypography.textTheme.bodySmall?.copyWith(
                          color: AppColors.slate600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        years,
                        style: AppTypography.textTheme.bodySmall?.copyWith(
                          color: AppColors.slate600,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Center Section (30%)
                Expanded(
                  flex: 30,
                  child: Column(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: scoreColor,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            score.toString(),
                            style: AppTypography.textTheme.headlineSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: scoreColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          riskLevel,
                          style: AppTypography.textTheme.labelSmall?.copyWith(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        traction,
                        style: AppTypography.textTheme.labelSmall?.copyWith(
                          color: tractionColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Right Section (30%)
                Expanded(
                  flex: 30,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _buildFinancialRow('Rev', revenue),
                      const SizedBox(height: 4),
                      _buildFinancialRow('Emp', employees),
                      const SizedBox(height: 4),
                      _buildFinancialRow('Lia', liabilities),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          _buildTrustIcon(trustFunded),
                          const SizedBox(width: 4),
                          _buildTrustIcon(trustPayments),
                          const SizedBox(width: 4),
                          _buildTrustIcon(trustStability),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFinancialRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          '$label:',
          style: AppTypography.textTheme.labelSmall?.copyWith(
            color: AppColors.slate600,
            fontSize: 11,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          value,
          style: AppTypography.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.slate900,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildTrustIcon(bool isTrustworthy) {
    return Icon(
      isTrustworthy ? LucideIcons.checkCircle : LucideIcons.xCircle,
      size: 14,
      color: isTrustworthy ? AppColors.successGreen : AppColors.slate400,
    );
  }
}
