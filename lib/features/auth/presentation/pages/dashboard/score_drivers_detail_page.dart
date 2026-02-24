import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:partnest/core/theme/app_colors.dart';
import 'package:partnest/core/theme/app_typography.dart';

class ScoreDriversDetailPage extends StatelessWidget {
  const ScoreDriversDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.slate50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: AppColors.slate200,
        leading: IconButton(
          icon: const Icon(LucideIcons.chevronLeft, color: AppColors.slate900),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Score Drivers',
          style: AppTypography.textTheme.headlineMedium,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.x, color: AppColors.slate900),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          children: [
            _buildDriverDetailCard(
              rank: '1st Factor',
              title: 'Revenue Consistency',
              contribution: '+18 points',
              status: 'Positive',
              statusColor: AppColors.successGreen,
              icon: LucideIcons.trendingUp,
              explanation:
                  'Revenue consistency is a key indicator of business stability and predictability. Businesses with stable revenue streams are better positioned to meet obligations and grow sustainably.',
              chartPlaceholder: 'Line Chart: Revenue Over Time',
              metrics: const {
                'Year 1 Revenue': '₦500,000',
                'Year 2 Revenue': '₦600,000 (+20%)',
                'Year 3 Revenue': '₦750,000 (+25%)',
                'Average Growth': '+22.5% YoY',
                'Consistency Score': '92/100 (very stable)',
              },
              recommendations: [
                'Maintain current revenue trajectory by expanding market reach',
                'Document revenue sources to demonstrate diversification',
                'Implement quarterly revenue forecasting for better predictability',
              ],
            ),
            _buildDriverDetailCard(
              rank: '2nd Factor',
              title: 'Expense Ratio',
              contribution: '+12 points',
              status: 'Neutral',
              statusColor: AppColors.trustBlue,
              icon: LucideIcons.pieChart,
              explanation:
                  'The expense-to-revenue ratio measures operational efficiency. A healthy ratio indicates good cost management and profitability potential.',
              chartPlaceholder: 'Pie Chart: Expense Breakdown\nCOGS(40%) | OpEx(35%) | Admin(15%) | Other(10%)',
              metrics: const {
                'Total Monthly Revenue': '₦50,000',
                'Total Monthly Expenses': '₦30,000',
                'Expense Ratio': '60%',
                'Profit Margin': '40%',
                'Efficiency Score': '85/100 (good)',
              },
              recommendations: [
                'Monitor cost of goods sold; consider supplier negotiations',
                'Optimize administrative expenses through automation',
                'Maintain current profit margin while scaling revenue',
              ],
            ),
            _buildDriverDetailCard(
              rank: '3rd Factor',
              title: 'Repayment Behavior',
              contribution: '+10 points',
              status: 'Positive',
              statusColor: AppColors.successGreen,
              icon: LucideIcons.checkCircle,
              explanation:
                  'A strong repayment history demonstrates financial reliability and creditworthiness. Lenders and investors view on-time payments as a positive signal.',
              chartPlaceholder: 'Bar Chart: Payment History\n24 of 24 payments on time (100%)',
              metrics: const {
                'Total Obligations': '24',
                'On-Time Payments': '24 (100%)',
                'Late Payments': '0',
                'Average Days Late': '0',
                'Reliability Score': '100/100 (excellent)',
              },
              recommendations: [
                'Continue maintaining perfect payment record',
                'Consider requesting credit limit increase from lenders',
                'Use payment history as leverage for better loan terms',
              ],
            ),

            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(LucideIcons.helpCircle, size: 16, color: AppColors.trustBlue),
                const SizedBox(width: 8),
                Text(
                  'Need help understanding your score?',
                  style: AppTypography.textTheme.bodyMedium?.copyWith(
                    color: AppColors.trustBlue,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildDriverDetailCard({
    required String rank,
    required String title,
    required String contribution,
    required String status,
    required Color statusColor,
    required IconData icon,
    required String explanation,
    required String chartPlaceholder,
    required Map<String, String> metrics,
    required List<String> recommendations,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.slate200),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppColors.slate200.withValues(alpha: 0.5),
            blurRadius: 4,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Text(
                rank,
                style: AppTypography.textTheme.labelMedium?.copyWith(
                  color: AppColors.slate600,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  status,
                  style: AppTypography.textTheme.labelSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: AppTypography.textTheme.headlineMedium?.copyWith(
                    fontSize: 20,
                    color: AppColors.slate900,
                  ),
                ),
              ),
              Icon(icon, size: 24, color: statusColor),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            contribution,
            style: AppTypography.textTheme.bodyMedium?.copyWith(
              color: statusColor,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 24),
          
          // Why This Matters
          Text(
            'Why This Matters',
            style: AppTypography.textTheme.headlineSmall?.copyWith(
              fontSize: 14,
              color: AppColors.slate900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            explanation,
            style: AppTypography.textTheme.bodyMedium?.copyWith(
              color: AppColors.slate700,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),

          // Chart Display
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.slate50,
              border: Border.all(color: AppColors.slate200),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Text(
                chartPlaceholder,
                textAlign: TextAlign.center,
                style: AppTypography.textTheme.bodyMedium?.copyWith(
                  color: AppColors.slate500,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Detailed Metrics
          ...metrics.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    entry.key,
                    style: AppTypography.textTheme.labelMedium?.copyWith(
                      color: AppColors.slate600,
                    ),
                  ),
                  Text(
                    entry.value,
                    style: AppTypography.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.slate900,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            );
          }),
          
          const SizedBox(height: 24),

          // Recommendations
          Text(
            'How to Improve',
            style: AppTypography.textTheme.headlineSmall?.copyWith(
              fontSize: 14,
              color: AppColors.slate900,
            ),
          ),
          const SizedBox(height: 12),
          ...recommendations.map((rec) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 6.0),
                    child: Icon(LucideIcons.arrowRightCircle, size: 14, color: AppColors.slate400),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      rec,
                      style: AppTypography.textTheme.bodyMedium?.copyWith(
                        color: AppColors.slate700,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
