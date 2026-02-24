import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:partnest/core/theme/app_colors.dart';
import 'package:partnest/core/theme/app_typography.dart';
import 'package:partnest/features/auth/presentation/pages/investor/comparison_watchlist_page.dart';

class DeepDiveEvidencePage extends StatelessWidget {
  const DeepDiveEvidencePage({super.key});

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
          'Evidence & Details',
          style: AppTypography.textTheme.headlineMedium,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.download, color: AppColors.trustBlue),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(LucideIcons.list, color: AppColors.slate900),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ComparisonWatchlistPage()),
              );
            },
            tooltip: 'Watchlist',
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          children: [
            // Score Summary
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColors.successGreen,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '85',
                      style: AppTypography.textTheme.headlineMedium?.copyWith(
                        fontSize: 32,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                        'Acme Manufacturing demonstrates strong financial health, consistent revenue growth, and reliable payment behavior. Low risk profile suitable for investment.',
                        style: AppTypography.textTheme.bodyMedium?.copyWith(
                          color: AppColors.slate700,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Score Drivers Evidence
            Text(
              'Key Score Drivers',
              style: AppTypography.textTheme.headlineSmall?.copyWith(
                color: AppColors.slate900,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            _buildEvidenceCard(
              title: 'Revenue Consistency',
              contribution: '+18 points',
              status: 'Positive',
              statusColor: AppColors.successGreen,
              evidence: 'Your revenue has remained stable over the past 3 years',
              chartPlaceholder: '[Line Chart: Year 1: ₦500K, Year 2: ₦600K, Year 3: ₦750K]',
              analysis: 'Revenue growth of 20% (Year 1->2) and 25% (Year 2->3) demonstrates consistent upward trajectory',
              metrics: {
                'Average YoY Growth': '22.5%',
                'Revenue Volatility': 'Low (std dev: 8%)',
                'Trend': 'Strongly positive',
              },
            ),
            const SizedBox(height: 12),
            _buildEvidenceCard(
              title: 'Expense Ratio',
              contribution: '+12 points',
              status: 'Neutral',
              statusColor: AppColors.trustBlue,
              evidence: 'Your expense-to-revenue ratio is within healthy range',
              chartPlaceholder: '[Pie Chart: COGS 40%, OpEx 35%, Admin 15%, Other 10%]',
              analysis: 'Expense ratio of 60% is healthy; indicates good cost management',
              metrics: {
                'Monthly Revenue': '₦50,000',
                'Monthly Expenses': '₦30,000',
                'Profit Margin': '40%',
                'Efficiency Score': '85/100',
              },
            ),
            const SizedBox(height: 12),
            _buildEvidenceCard(
              title: 'Repayment Behavior',
              contribution: '+10 points',
              status: 'Positive',
              statusColor: AppColors.successGreen,
              evidence: 'Perfect payment history; 24 of 24 payments on time',
              chartPlaceholder: '[Timeline Chart: Jan-Dec 100% on time]',
              analysis: '100% on-time payment rate demonstrates financial reliability',
              metrics: {
                'Total Obligations': '24',
                'On-Time Payments': '24 (100%)',
                'Late Payments': '0',
                'Reliability Score': '100/100',
              },
            ),

            const SizedBox(height: 32),

            // Financial Statements
            Text(
              'Financial Statements',
              style: AppTypography.textTheme.headlineSmall?.copyWith(
                color: AppColors.slate900,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            _buildFinancialTableGroup(
              'Income Statement',
              ['Metric', 'Year 1', 'Year 2', 'Year 3'],
              [
                ['Revenue', '500,000', '600,000', '750,000'],
                ['COGS', '200,000', '240,000', '300,000'],
                ['Gross Profit', '300,000', '360,000', '450,000'],
                ['Op. Expenses', '150,000', '180,000', '210,000'],
                ['Net Profit', '150,000', '180,000', '240,000'],
              ],
            ),
            _buildFinancialTableGroup(
              'Balance Sheet',
              ['Metric', 'Year 1', 'Year 2', 'Year 3'],
              [
                ['Assets', '800,000', '950,000', '1,200,000'],
                ['Liabilities', '300,000', '350,000', '400,000'],
                ['Equity', '500,000', '600,000', '800,000'],
              ],
            ),

            const SizedBox(height: 32),

            // Supporting Documents
            Text(
              'Supporting Documents',
              style: AppTypography.textTheme.headlineSmall?.copyWith(
                color: AppColors.slate900,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            _buildDocumentCard(
              title: 'Bank Statements',
              metadata: 'Uploaded: Feb 20, 2026 • 2.3 MB',
              fileType: 'PDF',
            ),
            _buildDocumentCard(
              title: 'Tax Returns',
              metadata: 'Uploaded: Feb 18, 2026 • 1.8 MB',
              fileType: 'PDF',
            ),
            _buildDocumentCard(
              title: 'Financial Audit',
              metadata: 'Uploaded: Feb 15, 2026 • 3.2 MB',
              fileType: 'PDF',
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildEvidenceCard({
    required String title,
    required String contribution,
    required String status,
    required Color statusColor,
    required String evidence,
    required String chartPlaceholder,
    required String analysis,
    required Map<String, String> metrics,
  }) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: AppColors.slate200),
      ),
      color: Colors.white,
      child: ExpansionTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: AppTypography.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.slate900,
                ),
              ),
            ),
            Text(
              contribution,
              style: AppTypography.textTheme.bodyMedium?.copyWith(
                color: statusColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        subtitle: Row(
          children: [
            Icon(LucideIcons.check, size: 14, color: statusColor),
            const SizedBox(width: 4),
            Text(
              status,
              style: AppTypography.textTheme.bodySmall?.copyWith(color: statusColor),
            ),
          ],
        ),
        childrenPadding: const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 0),
        children: [
          Divider(color: AppColors.slate200),
          const SizedBox(height: 8),
          Text(
            evidence,
            style: AppTypography.textTheme.bodyMedium?.copyWith(color: AppColors.slate600),
          ),
          const SizedBox(height: 16),
          Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.slate50,
              border: Border.all(color: AppColors.slate200),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Text(
                chartPlaceholder,
                style: AppTypography.textTheme.bodySmall?.copyWith(color: AppColors.slate500),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            analysis,
            style: AppTypography.textTheme.bodyMedium?.copyWith(
              color: AppColors.slate700,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          ...metrics.entries.map((entry) => Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  entry.key,
                  style: AppTypography.textTheme.labelMedium?.copyWith(color: AppColors.slate600),
                ),
                Text(
                  entry.value,
                  style: AppTypography.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.slate900,
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildFinancialTableGroup(String title, List<String> columns, List<List<String>> rows) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: AppColors.slate200),
      ),
      color: Colors.white,
      child: ExpansionTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        title: Text(
          title,
          style: AppTypography.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.slate900,
          ),
        ),
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor: WidgetStateProperty.all(AppColors.slate50),
              columns: columns.map((col) => DataColumn(
                label: Text(
                  col,
                  style: AppTypography.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.slate900,
                  ),
                ),
              )).toList(),
              rows: rows.map((rowCells) {
                return DataRow(
                  cells: rowCells.map((cellValue) {
                    final isFirstCol = rowCells.indexOf(cellValue) == 0;
                    return DataCell(
                      Text(
                        cellValue,
                        style: AppTypography.textTheme.bodySmall?.copyWith(
                          fontWeight: isFirstCol ? FontWeight.w600 : FontWeight.w400,
                          color: AppColors.slate900,
                        ),
                      ),
                    );
                  }).toList(),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentCard({required String title, required String metadata, required String fileType}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.slate50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.slate200),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: AppColors.slate200),
            ),
            child: const Icon(LucideIcons.fileText, size: 20, color: AppColors.slate600),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.slate900,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  metadata,
                  style: AppTypography.textTheme.bodySmall?.copyWith(
                    color: AppColors.slate600,
                  ),
                ),
              ],
            ),
          ),
          Text(
            'Download',
            style: AppTypography.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.trustBlue,
            ),
          ),
        ],
      ),
    );
  }
}
