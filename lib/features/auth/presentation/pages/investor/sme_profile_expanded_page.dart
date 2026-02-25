import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:partnest/core/theme/app_colors.dart';
import 'package:partnest/core/theme/app_typography.dart';
import 'package:partnest/core/theme/widgets/custom_button.dart';
import 'package:partnest/features/auth/presentation/pages/investor/deep_dive_evidence_page.dart';

// Message SME Bottom Sheet (Screen 14B)
class MessageSmeBottomSheet extends StatefulWidget {
  final String companyName;

  const MessageSmeBottomSheet({super.key, required this.companyName});

  @override
  State<MessageSmeBottomSheet> createState() => _MessageSmeBottomSheetState();
}

class _MessageSmeBottomSheetState extends State<MessageSmeBottomSheet> {
  final String defaultMessageTemplate = "Hi {company}, I'm interested in learning more about your business and potential investment opportunities. Your credibility score caught my attention. Let's connect!";

  @override
  Widget build(BuildContext context) {
    String formattedMessage = defaultMessageTemplate.replaceAll('{company}', widget.companyName);

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min, // Wrap content tightly vertically
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Contact ${widget.companyName}',
                        style: AppTypography.textTheme.headlineSmall?.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.slate900,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Choose how you'd like to reach out",
                        style: AppTypography.textTheme.bodyMedium?.copyWith(
                          fontSize: 14,
                          color: AppColors.slate600,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(LucideIcons.x, color: AppColors.slate900),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Social Media Options Grid
            Row(
              children: [
                Expanded(child: _buildSocialOption('WhatsApp', Icons.call, const Color(0xFF25D366), 'WhatsApp')), // Use generic icon since Lucide lacks WhatsApp
                const SizedBox(width: 12),
                Expanded(child: _buildSocialOption('LinkedIn', LucideIcons.linkedin, const Color(0xFF0A66C2), 'LinkedIn')),
                const SizedBox(width: 12),
                Expanded(child: _buildSocialOption('Twitter', LucideIcons.twitter, const Color(0xFF1DA1F2), 'Twitter')),
              ],
            ),
            const SizedBox(height: 24),

            // Pre-Filled Message
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.slate50,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    formattedMessage,
                    style: AppTypography.textTheme.bodyMedium?.copyWith(
                      fontSize: 12,
                      color: AppColors.slate600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: () {}, // Action to edit message
                    child: Text(
                        'Edit message',
                        style: AppTypography.textTheme.bodySmall?.copyWith(
                          fontSize: 12,
                          color: AppColors.trustBlue,
                        ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Direct Contact Information
            _buildDirectContact('Email', 'contact@acmemanufacturing.com', LucideIcons.mail),
            const SizedBox(height: 12),
            _buildDirectContact('Phone', '+234 (0) 123 456 7890', LucideIcons.phone),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialOption(String label, IconData iconData, Color colorHex, String tooltip) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {}, // Action to open native app
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: colorHex.withValues(alpha: 0.1),
            border: Border.all(color: AppColors.slate200),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(iconData, size: 32, color: colorHex),
              const SizedBox(height: 8),
              Text(
                label,
                style: AppTypography.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: AppColors.slate900,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDirectContact(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.slate400),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(
               label,
               style: AppTypography.textTheme.labelSmall?.copyWith(
                 color: AppColors.slate600,
                 fontSize: 12,
               ),
             ),
             Text(
               value,
               style: AppTypography.textTheme.bodyMedium?.copyWith(
                 color: AppColors.slate900,
                 fontWeight: FontWeight.w600,
                 fontSize: 14,
               ),
             ),
          ],
        ),
      ],
    );
  }
}


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

  void _openMessageSheet() {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent, // Let Container handle rounding
        builder: (context) => const MessageSmeBottomSheet(companyName: 'Acme Manufacturing'),
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
        elevation: 0, // Removed elevation as per modern minimalist trends implicitly
        leading: IconButton(
          icon: const Icon(LucideIcons.chevronLeft, color: AppColors.slate900),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'SME Profile',
          style: AppTypography.textTheme.headlineMedium?.copyWith(
            fontSize: 16, // Typical appbar title size
            color: AppColors.slate900,
            fontWeight: FontWeight.w600,
          ),
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
            // Company Header
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: AppColors.trustBlue.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      'AM', // Initials
                      style: TextStyle(
                        color: AppColors.trustBlue,
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                      ),
                    ),
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
                        'Manufacturing · Lagos, Nigeria',
                        style: AppTypography.textTheme.bodyMedium?.copyWith(
                          fontSize: 14,
                          color: AppColors.slate600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '5 years in operation',
                        style: AppTypography.textTheme.bodyMedium?.copyWith(
                          fontSize: 14,
                          color: AppColors.slate600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                             const Icon(LucideIcons.externalLink, size: 14, color: AppColors.trustBlue),
                             const SizedBox(width: 4),
                             Text(
                              'www.acmemanufacturing.com',
                              style: AppTypography.textTheme.bodyMedium?.copyWith(
                                color: AppColors.trustBlue,
                                fontSize: 14,
                              ),
                             ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 24),

            // Score Badge (Large Centered Circle)
            Center(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _navigateToEvidence,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: AppColors.successGreen,
                        shape: BoxShape.circle,
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.1),
                            blurRadius: 12,
                            offset: Offset(0, 4),
                          )
                        ],
                      ),
                      child: Center(
                        child: Text(
                          '85',
                          style: AppTypography.textTheme.displayLarge?.copyWith(
                            fontSize: 56,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.successGreen,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'Low Risk',
                      style: AppTypography.textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Generated on Feb 25, 2026 at 1:32 PM',
                    style: AppTypography.textTheme.bodySmall?.copyWith(
                      color: AppColors.slate600,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Key Metrics Grid
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.8,
              children: [
                _buildMetricCard('Annual Revenue', '₦750K', 'Positive', AppColors.successGreen),
                _buildMetricCard('Employees', '25', 'Positive', AppColors.successGreen),
                _buildMetricCard('Liabilities', '₦200K', 'Moderate', AppColors.warningAmber),
                _buildMetricCard('Profit Margin', '40%', 'Healthy', AppColors.successGreen),
              ],
            ),

            const SizedBox(height: 32),

            // Trust Signals
            _buildTrustSignalCard(
              title: 'Received Prior Funding',
              explanation: '₦100K from VC in 2022',
            ),
            _buildTrustSignalCard(
              title: 'Payment Timeliness',
              explanation: '24 of 24 payments on time',
            ),
            _buildTrustSignalCard(
              title: 'Revenue Stability',
              explanation: 'Consistent +22% YoY growth',
            ),

            const SizedBox(height: 32),

            // Actions Section
            CustomButton(
              text: 'Message SME',
              variant: ButtonVariant.primary,
              onPressed: _openMessageSheet,
            ),
            const SizedBox(height: 12),
            CustomButton(
              text: 'View Evidence & Details',
              variant: ButtonVariant.secondary, // Light gray
              onPressed: _navigateToEvidence,
            ),
            const SizedBox(height: 12),

            // Tertiary bottom actions
            Row(
              children: [
                Expanded(
                  child: TextButton.icon(
                    onPressed: _toggleWatchlist,
                    icon: Icon(
                      _isWatchlisted ? LucideIcons.heart : LucideIcons.heart, // Ideally filled heart if watchlisted
                      size: 16, 
                      color: AppColors.trustBlue,
                    ),
                    label: Text(
                      _isWatchlisted ? 'Remove' : 'Add to Watchlist',
                      style: AppTypography.textTheme.bodyMedium?.copyWith(
                        color: AppColors.trustBlue,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton.icon(
                     onPressed: () {},
                     icon: const Icon(LucideIcons.share2, size: 16, color: AppColors.trustBlue),
                     label: Text(
                        'Share',
                        style: AppTypography.textTheme.bodyMedium?.copyWith(
                          color: AppColors.trustBlue,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
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

  Widget _buildMetricCard(String label, String value, String statusText, Color statusColor) {
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
          Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
                Text(
                  label,
                  style: AppTypography.textTheme.labelMedium?.copyWith(
                    color: AppColors.slate600,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  statusText,
                  style: AppTypography.textTheme.labelSmall?.copyWith(
                    color: statusColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
             ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: AppTypography.textTheme.headlineSmall?.copyWith(
              color: AppColors.slate900,
              fontSize: 18,
              fontWeight: FontWeight.w700,
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
    required String explanation,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.successGreen.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.successGreen),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(LucideIcons.checkCircle, color: AppColors.successGreen, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.textTheme.bodyMedium?.copyWith(
                    color: AppColors.slate900,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                Text(
                  explanation,
                  style: AppTypography.textTheme.bodySmall?.copyWith(
                    color: AppColors.slate600,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
