import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:partnest/core/theme/app_colors.dart';
import 'package:partnest/core/theme/app_typography.dart';
import 'package:partnest/features/auth/presentation/pages/investor/sme_profile_expanded_page.dart';

class ComparisonWatchlistPage extends StatefulWidget {
  const ComparisonWatchlistPage({super.key});

  @override
  State<ComparisonWatchlistPage> createState() => _ComparisonWatchlistPageState();
}

class _ComparisonWatchlistPageState extends State<ComparisonWatchlistPage> {
  final List<Map<String, dynamic>> _watchlist = [
    {
      'id': '1',
      'name': 'Acme Manufacturing',
      'score': 85,
      'scoreColor': AppColors.successGreen,
      'risk': 'Low Risk',
      'added': 'Feb 24, 2026',
      'revenue': '₦750K',
      'employees': '25',
      'liabilities': '₦200K',
      'profitMargin': '40%',
      'growthRate': '+22%',
      'paymentHistory': 'On Time',
    },
    {
      'id': '2',
      'name': 'TechStart Solutions',
      'score': 62,
      'scoreColor': AppColors.warningAmber,
      'risk': 'Medium Risk',
      'added': 'Feb 23, 2026',
      'revenue': '₦500K',
      'employees': '12',
      'liabilities': '₦150K',
      'profitMargin': '35%',
      'growthRate': '+45%',
      'paymentHistory': 'On Time',
    },
    {
      'id': '3',
      'name': 'Traditional Retail Ltd',
      'score': 45,
      'scoreColor': AppColors.dangerRed,
      'risk': 'High Risk',
      'added': 'Feb 20, 2026',
      'revenue': '₦300K',
      'employees': '8',
      'liabilities': '₦400K',
      'profitMargin': '20%',
      'growthRate': '-5%',
      'paymentHistory': 'Late',
    },
  ];

  final Set<String> _selectedForComparison = {};

  bool get _isComparing => _selectedForComparison.length > 1;

  void _toggleSelection(String id) {
    setState(() {
      if (_selectedForComparison.contains(id)) {
        _selectedForComparison.remove(id);
      } else {
        if (_selectedForComparison.length < 3) {
          _selectedForComparison.add(id);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('You can only compare up to 3 SMEs at a time', style: AppTypography.textTheme.bodyMedium?.copyWith(color: Colors.white)),
              backgroundColor: AppColors.slate900,
            ),
          );
        }
      }
    });
  }

  void _navigateToProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SmeProfileExpandedPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final watchlistedItems = _watchlist;
    final comparingItems = _watchlist.where((item) => _selectedForComparison.contains(item['id'])).toList();

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
          'Watchlist',
          style: AppTypography.textTheme.headlineMedium,
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _selectedForComparison.clear();
              });
            },
            child: Text(
              'Clear',
              style: AppTypography.textTheme.bodyMedium?.copyWith(color: AppColors.slate600),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Sorting & Filter Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${watchlistedItems.length} SMEs Saved',
                    style: AppTypography.textTheme.bodyMedium?.copyWith(
                      color: AppColors.slate600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        Text(
                          'Sort by: Date Added',
                          style: AppTypography.textTheme.bodyMedium?.copyWith(
                            color: AppColors.slate900,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(LucideIcons.chevronDown, size: 16, color: AppColors.slate600),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),

            // Main Content
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  // Comparison View
                  if (_isComparing) ...[
                    Text(
                      'Comparison View',
                      style: AppTypography.textTheme.headlineSmall?.copyWith(
                        color: AppColors.slate900,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildComparisonTable(comparingItems),
                    const SizedBox(height: 32),
                    Divider(color: AppColors.slate200),
                    const SizedBox(height: 24),
                  ],

                  // Instruction Text if not comparing
                  if (!_isComparing && watchlistedItems.isNotEmpty) ...[
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.trustBlue.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(LucideIcons.info, size: 20, color: AppColors.trustBlue),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Select 2 or 3 SMEs below to compare them side-by-side.',
                              style: AppTypography.textTheme.bodyMedium?.copyWith(
                                color: AppColors.trustBlue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],

                  // Watchlist Cards
                  Text(
                    'Your Watchlist',
                    style: AppTypography.textTheme.headlineSmall?.copyWith(
                      color: AppColors.slate900,
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (watchlistedItems.isEmpty)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Text(
                          'Your watchlist is empty.',
                          style: AppTypography.textTheme.bodyLarge?.copyWith(
                            color: AppColors.slate500,
                          ),
                        ),
                      ),
                    ),
                  ...watchlistedItems.map((sme) => _buildWatchlistCard(sme)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWatchlistCard(Map<String, dynamic> sme) {
    final isSelected = _selectedForComparison.contains(sme['id']);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.trustBlue.withValues(alpha: 0.05) : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isSelected ? AppColors.trustBlue : AppColors.slate200,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: InkWell(
        onTap: _navigateToProfile,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Checkbox for comparison
              InkWell(
                onTap: () => _toggleSelection(sme['id']),
                child: Container(
                  width: 24,
                  height: 24,
                  margin: const EdgeInsets.only(top: 4, right: 12),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.trustBlue : Colors.white,
                    border: Border.all(
                      color: isSelected ? AppColors.trustBlue : AppColors.slate300,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: isSelected
                      ? const Icon(LucideIcons.check, size: 16, color: Colors.white)
                      : null,
                ),
              ),

              // Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            sme['name'],
                            style: AppTypography.textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.slate900,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _watchlist.removeWhere((item) => item['id'] == sme['id']);
                              _selectedForComparison.remove(sme['id']);
                            });
                          },
                          child: const Icon(LucideIcons.trash2, size: 18, color: AppColors.slate400),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          sme['score'].toString(),
                          style: AppTypography.textTheme.headlineMedium?.copyWith(
                            fontSize: 24,
                            color: sme['scoreColor'],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: sme['scoreColor'].withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            sme['risk'],
                            style: AppTypography.textTheme.labelSmall?.copyWith(
                              color: sme['scoreColor'],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Added ${sme['added']}',
                          style: AppTypography.textTheme.bodySmall?.copyWith(
                            color: AppColors.slate500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildComparisonTable(List<Map<String, dynamic>> items) {
    if (items.isEmpty) return const SizedBox.shrink();

    final metrics = [
      {'label': 'Score', 'key': 'score'},
      {'label': 'Risk Level', 'key': 'risk'},
      {'label': 'Revenue', 'key': 'revenue'},
      {'label': 'Employees', 'key': 'employees'},
      {'label': 'Liabilities', 'key': 'liabilities'},
      {'label': 'Profit Margin', 'key': 'profitMargin'},
      {'label': 'Growth Rate', 'key': 'growthRate'},
      {'label': 'Payment History', 'key': 'paymentHistory'},
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.slate200),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor: WidgetStateProperty.all(AppColors.slate50),
          dataRowMinHeight: 48,
          dataRowMaxHeight: 48,
          columns: [
            DataColumn(
              label: Text(
                'Metric',
                style: AppTypography.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.slate900,
                ),
              ),
            ),
            ...items.map((item) => DataColumn(
              label: Text(
                item['name'],
                style: AppTypography.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.trustBlue,
                ),
              ),
            )),
          ],
          rows: metrics.map((metricRow) {
            return DataRow(
              cells: [
                DataCell(
                  Text(
                    metricRow['label']!,
                    style: AppTypography.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.slate700,
                    ),
                  ),
                ),
                ...items.map((item) {
                  final val = item[metricRow['key']!].toString();
                  Color textColor = AppColors.slate900;
                  FontWeight weight = FontWeight.w400;

                  if (metricRow['key'] == 'score') {
                    textColor = item['scoreColor'];
                    weight = FontWeight.w700;
                  }

                  return DataCell(
                    Text(
                      val,
                      style: AppTypography.textTheme.bodySmall?.copyWith(
                        color: textColor,
                        fontWeight: weight,
                      ),
                    ),
                  );
                }),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
