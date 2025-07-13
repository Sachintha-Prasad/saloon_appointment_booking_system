// Create a new file: lib/screens/client/home/widgets/modern_empty_state.dart

import 'package:flutter/material.dart';
import 'package:saloon_appointment_booking_system/utils/constants/colors.dart';

class EmptyState extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onRefresh;
  final IconData icon;
  final String buttonText;

  const EmptyState({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onRefresh,
    this.icon = Icons.event_available_rounded,
    this.buttonText = "Refresh",
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildGradientIconContainer(),
          const SizedBox(height: 32),
          _buildMainTitle(isDarkMode),
          const SizedBox(height: 12),
          _buildSubtitle(isDarkMode),
          const SizedBox(height: 40),
          _buildRefreshButton(),
          const SizedBox(height: 24),
          _buildInfoCard(isDarkMode),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildGradientIconContainer() {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            SBColors.primary.withOpacity(0.1),
            SBColors.primary.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(60),
        border: Border.all(
          color: SBColors.primary.withOpacity(0.2),
          width: 2,
        ),
      ),
      child: Icon(
        icon,
        size: 54,
        color: SBColors.primary.withOpacity(0.7),
      ),
    );
  }

  Widget _buildMainTitle(bool isDarkMode) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: isDarkMode ? Colors.white : const Color(0xFF2C3E50),
        letterSpacing: -0.5,
      ),
    );
  }

  Widget _buildSubtitle(bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Text(
        subtitle,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
          height: 1.4,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buildRefreshButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [
            SBColors.primary,
            SBColors.primary.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: SBColors.primary.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onRefresh,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 14),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.refresh_rounded, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                Text(
                  buttonText,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(bool isDarkMode) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color:
            isDarkMode ? Colors.grey[850]?.withOpacity(0.5) : Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDarkMode ? Colors.grey[700]! : Colors.grey[200]!,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: SBColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.info_outline_rounded,
              color: SBColors.primary,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Need Help?",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? Colors.white : const Color(0xFF2C3E50),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Contact the salon for appointment status updates",
                  style: TextStyle(
                    fontSize: 14,
                    color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                    height: 1.3,
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
