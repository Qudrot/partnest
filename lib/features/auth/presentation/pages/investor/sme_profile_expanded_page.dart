import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:partnest/core/theme/app_colors.dart';
import 'package:partnest/core/theme/app_typography.dart';
import 'package:partnest/core/theme/widgets/custom_button.dart';
import 'package:partnest/features/auth/presentation/pages/investor/deep_dive_evidence_page.dart';

class SmeProfileExpandedPage extends StatefulWidget {
  const SmeProfileExpandedPage({super.key});

  @override
  State<SmeProfileExpandedPage> createState() => _SmeProfileExpandedPageState();
}

class _SmeProfileExpandedPageState extends State<SmeProfileExpandedPage> {
  bool _isWatchlisted = false;

  void _navigateToEvidence() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const DeepDiveEvidencePage()),
    );
  }

  void _toggleWatchlist() {
    setState(() {
      _isWatchlisted = !_isWatchlisted;
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isWatchlisted ? 'Added to watchlist' : 'Removed from watchlist',
          style: AppTypography.textTheme.bodyMedium?.copyWith(color: Colors.white),
        ),
        backgroundColor: AppColors.slate900,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: AppColors.slate200,
        leading: IconButton(
          icon: const Icon(LucideIcons.chevronLeft, color: AppColors.slate900),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'SME Profile',
          style: AppTypography.textTheme.headlineMedium,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.moreVertical, color: AppColors.slate900),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          children: [
            // Hero Section
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColors.slate100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.slate200),
                  ),
                  child: const Center(
                    child: Icon(LucideIcons.building, size: 32, color: AppColors.slate400),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Acme Manufacturing',
                        style: AppTypography.textTheme.headlineMedium?.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: AppColors.slate900,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Manufacturing',
                        style: AppTypography.textTheme.bodyMedium?.copyWith(
                          color: AppColors.slate600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Lagos, Nigeria',
                        style: AppTypography.textTheme.bodyMedium?.copyWith(
                          color: AppColors.slate600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '5 years in operation',
                        style: AppTypography.textTheme.bodyMedium?.copyWith(
                          color: AppColors.slate600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      InkWell(
                        onTap: () {},
                        child: Text(
                          'www.acmemanufacturing.com',
                          style: AppTypography.textTheme.bodyMedium?.copyWith(
                            color: AppColors.trustBlue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 24),

            // Score Banner
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.slate50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.slate200),
              ),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppColors.successGreen,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '85',
                        style: AppTypography.textTheme.headlineMedium?.copyWith(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.successGreen.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: AppColors.successGreen.withValues(alpha: 0.3)),
                        ),
                        child: Text(
                          'Low Risk',
                          style: AppTypography.textTheme.labelSmall?.copyWith(
                            color: AppColors.successGreen,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Last Updated: Feb 24, 2026',
                        style: AppTypography.textTheme.bodySmall?.copyWith(
                          color: AppColors.slate500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Key Metrics
            Text(
              'Key Metrics',
              style: AppTypography.textTheme.headlineSmall?.copyWith(
                color: AppColors.slate900,
              ),
            ),
            const SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 2,
              children: [
                _buildMetricCard('Annual Revenue', '₦750,000', '↑ 22% YoY', AppColors.successGreen),
                _buildMetricCard('Employees', '25', 'Stable', AppColors.trustBlue),
                _buildMetricCard('Liabilities', '₦200,000', '27% of revenue', AppColors.warningAmber),
                _buildMetricCard('Profit Margin', '40%', 'Healthy', AppColors.successGreen),
              ],
            ),

            const SizedBox(height: 32),

            // Trust Signals
            Text(
              'Trust Signals',
              style: AppTypography.textTheme.headlineSmall?.copyWith(
                color: AppColors.slate900,
              ),
            ),
            const SizedBox(height: 16),
            _buildTrustSignalCard(
              title: 'Received Prior Funding',
              status: 'Yes',
              icon: LucideIcons.checkCircle,
              color: AppColors.successGreen,
              details: [
                'Amount: ₦100,000',
                'Source: Venture Capital',
                'Year: 2022',
              ],
            ),
            _buildTrustSignalCard(
              title: 'Payment Timeliness',
              status: 'Always on time',
              icon: LucideIcons.checkCircle,
              color: AppColors.successGreen,
              details: [
                'Record: 24 of 24 payments on time',
              ],
            ),
            _buildTrustSignalCard(
              title: 'Revenue Stability',
              status: 'Consistent growth',
              icon: LucideIcons.checkCircle,
              color: AppColors.successGreen,
              details: [
                'Trend: +20%, +25% YoY',
              ],
            ),
            _buildTrustSignalCard(
              title: 'Default History',
              status: 'No defaults',
              icon: LucideIcons.xCircle,
              color: AppColors.slate400,
              details: [
                'Status: Clean record',
              ],
            ),

            const SizedBox(height: 32),

            // Actions
            CustomButton(
              text: 'View Evidence & Details',
              variant: ButtonVariant.primary,
              // We simulate the chevron right via appending it to text or overriding styling
              // Or keeping it simple as a custom button
              onPressed: _navigateToEvidence,
            ),
            const SizedBox(height: 12),
            CustomButton(
              text: _isWatchlisted ? 'Remove from Watchlist' : 'Add to Watchlist',
              variant: ButtonVariant.secondary,
              onPressed: _toggleWatchlist,
            ),
            const SizedBox(height: 12),
            CustomButton(
              text: 'Contact SME',
              variant: ButtonVariant.secondary,
              onPressed: () {},
            ),
            const SizedBox(height: 12),
            CustomButton(
              text: 'Share Profile',
              variant: ButtonVariant.secondary,
              onPressed: () {},
            ),

            const SizedBox(height: 32),
            
            // Footer
            Center(
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Report this profile',
                  style: AppTypography.textTheme.bodyMedium?.copyWith(
                    color: AppColors.slate500,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(String label, String value, String context, Color contextColor) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.slate50,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.slate200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: AppTypography.textTheme.labelMedium?.copyWith(
              color: AppColors.slate600,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: AppTypography.textTheme.headlineSmall?.copyWith(
              color: AppColors.slate900,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            context,
            style: AppTypography.textTheme.bodySmall?.copyWith(
              color: contextColor,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildTrustSignalCard({
    required String title,
    required String status,
    required IconData icon,
    required Color color,
    required List<String> details,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.slate200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '$title: ',
                      style: AppTypography.textTheme.bodyMedium?.copyWith(
                        color: AppColors.slate900,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        status,
                        style: AppTypography.textTheme.bodyMedium?.copyWith(
                          color: color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                if (details.isNotEmpty) const SizedBox(height: 8),
                ...details.map((detail) => Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 6.0),
                        child: Icon(LucideIcons.minus, size: 8, color: AppColors.slate400),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          detail,
                          style: AppTypography.textTheme.bodySmall?.copyWith(
                            color: AppColors.slate600,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
