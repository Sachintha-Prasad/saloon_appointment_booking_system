import 'package:flutter/material.dart';

class StatusChip extends StatefulWidget {
  final String status;
  final double? fontSize;
  final EdgeInsets? padding;
  final double? borderRadius;
  final bool animated;
  final Duration animationDuration;
  final IconData? icon;
  final bool showIcon;
  final double? iconSize;
  final VoidCallback? onTap;
  final bool isSelected;
  final Color? customColor;
  final Color? customTextColor;

  const StatusChip({
    Key? key,
    required this.status,
    this.fontSize = 12,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    this.borderRadius = 20,
    this.animated = true,
    this.animationDuration = const Duration(milliseconds: 300),
    this.icon,
    this.showIcon = true,
    this.iconSize = 14,
    this.onTap,
    this.isSelected = false,
    this.customColor,
    this.customTextColor,
  }) : super(key: key);

  @override
  State<StatusChip> createState() => _StatusChipState();
}

class _StatusChipState extends State<StatusChip>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));
    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    if (widget.animated) {
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  StatusChipData _getStatusData() {
    final statusLower = widget.status.toLowerCase();

    switch (statusLower) {
      case 'approved':
      case 'confirmed':
      case 'completed':
        return StatusChipData(
          color: const Color(0xFF10B981),
          textColor: Colors.white,
          icon: Icons.check_circle,
        );
      case 'pending':
      case 'waiting':
        return StatusChipData(
          color: const Color(0xFFF59E0B),
          textColor: Colors.white,
          icon: Icons.schedule,
        );
      case 'cancelled':
      case 'rejected':
        return StatusChipData(
          color: const Color(0xFFEF4444),
          textColor: Colors.white,
          icon: Icons.cancel,
        );
      case 'in progress':
      case 'ongoing':
        return StatusChipData(
          color: const Color(0xFF3B82F6),
          textColor: Colors.white,
          icon: Icons.play_circle,
        );
      case 'rescheduled':
        return StatusChipData(
          color: const Color(0xFF8B5CF6),
          textColor: Colors.white,
          icon: Icons.update,
        );
      case 'draft':
        return StatusChipData(
          color: const Color(0xFF6B7280),
          textColor: Colors.white,
          icon: Icons.edit,
        );
      default:
        return StatusChipData(
          color: const Color(0xFF6B7280),
          textColor: Colors.white,
          icon: Icons.info,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusData = _getStatusData();
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final backgroundColor = widget.customColor ?? statusData.color;
    final textColor = widget.customTextColor ?? statusData.textColor;
    final iconData = widget.icon ?? statusData.icon;

    Widget chipContent = Container(
      padding: widget.padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(widget.borderRadius!),
        boxShadow: [
          BoxShadow(
            color: backgroundColor.withOpacity(0.3),
            spreadRadius: 0,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: widget.isSelected
            ? Border.all(
                color: isDarkMode ? Colors.white : Colors.black,
                width: 2,
              )
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.showIcon && iconData != null) ...[
            Icon(
              iconData,
              size: widget.iconSize,
              color: textColor,
            ),
            const SizedBox(width: 4),
          ],
          Text(
            widget.status,
            style: TextStyle(
              color: textColor,
              fontSize: widget.fontSize,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );

    if (widget.onTap != null) {
      chipContent = GestureDetector(
        onTap: widget.onTap,
        child: chipContent,
      );
    }

    if (widget.animated) {
      return AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Opacity(
              opacity: _opacityAnimation.value,
              child: chipContent,
            ),
          );
        },
      );
    }

    return chipContent;
  }
}

/// Data class for status chip styling
class StatusChipData {
  final Color color;
  final Color textColor;
  final IconData icon;

  StatusChipData({
    required this.color,
    required this.textColor,
    required this.icon,
  });
}

/// Gradient Status Chip Variant
class GradientStatusChip extends StatelessWidget {
  final String status;
  final double? fontSize;
  final EdgeInsets? padding;
  final double? borderRadius;
  final IconData? icon;
  final bool showIcon;
  final double? iconSize;
  final VoidCallback? onTap;
  final List<Color>? customGradient;

  const GradientStatusChip({
    Key? key,
    required this.status,
    this.fontSize = 12,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    this.borderRadius = 20,
    this.icon,
    this.showIcon = true,
    this.iconSize = 14,
    this.onTap,
    this.customGradient,
  }) : super(key: key);

  List<Color> _getGradientColors() {
    if (customGradient != null) return customGradient!;

    final statusLower = status.toLowerCase();

    switch (statusLower) {
      case 'accepted':
      case 'confirmed':
      case 'completed':
        return [const Color(0xFF10B981), const Color(0xFF059669)];
      case 'pending':
      case 'waiting':
        return [const Color(0xFFF59E0B), const Color(0xFFD97706)];
      case 'cancelled':
      case 'rejected':
        return [const Color(0xFFEF4444), const Color(0xFFDC2626)];
      case 'in progress':
      case 'ongoing':
        return [const Color(0xFF3B82F6), const Color(0xFF2563EB)];
      case 'rescheduled':
        return [const Color(0xFF8B5CF6), const Color(0xFF7C3AED)];
      default:
        return [const Color(0xFF6B7280), const Color(0xFF4B5563)];
    }
  }

  IconData _getIcon() {
    if (icon != null) return icon!;

    final statusLower = status.toLowerCase();

    switch (statusLower) {
      case 'accepted':
      case 'confirmed':
      case 'completed':
        return Icons.check_circle;
      case 'pending':
      case 'waiting':
        return Icons.schedule;
      case 'cancelled':
      case 'rejected':
        return Icons.cancel;
      case 'in progress':
      case 'ongoing':
        return Icons.play_circle;
      case 'rescheduled':
        return Icons.update;
      default:
        return Icons.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    final gradientColors = _getGradientColors();
    final iconData = _getIcon();

    Widget chipContent = Container(
      padding: padding,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(borderRadius!),
        boxShadow: [
          BoxShadow(
            color: gradientColors.first.withOpacity(0.3),
            spreadRadius: 0,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showIcon) ...[
            Icon(
              iconData,
              size: iconSize,
              color: Colors.white,
            ),
            const SizedBox(width: 4),
          ],
          Text(
            status,
            style: TextStyle(
              color: Colors.white,
              fontSize: fontSize,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );

    if (onTap != null) {
      chipContent = GestureDetector(
        onTap: onTap,
        child: chipContent,
      );
    }

    return chipContent;
  }
}

/// Outlined Status Chip Variant
class OutlinedStatusChip extends StatelessWidget {
  final String status;
  final double? fontSize;
  final EdgeInsets? padding;
  final double? borderRadius;
  final IconData? icon;
  final bool showIcon;
  final double? iconSize;
  final VoidCallback? onTap;
  final double borderWidth;

  const OutlinedStatusChip({
    Key? key,
    required this.status,
    this.fontSize = 12,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    this.borderRadius = 20,
    this.icon,
    this.showIcon = true,
    this.iconSize = 14,
    this.onTap,
    this.borderWidth = 1.5,
  }) : super(key: key);

  Color _getColor() {
    final statusLower = status.toLowerCase();

    switch (statusLower) {
      case 'accepted':
      case 'confirmed':
      case 'completed':
        return const Color(0xFF10B981);
      case 'pending':
      case 'waiting':
        return const Color(0xFFF59E0B);
      case 'cancelled':
      case 'rejected':
        return const Color(0xFFEF4444);
      case 'in progress':
      case 'ongoing':
        return const Color(0xFF3B82F6);
      case 'rescheduled':
        return const Color(0xFF8B5CF6);
      default:
        return const Color(0xFF6B7280);
    }
  }

  IconData _getIcon() {
    if (icon != null) return icon!;

    final statusLower = status.toLowerCase();

    switch (statusLower) {
      case 'accepted':
      case 'confirmed':
      case 'completed':
        return Icons.check_circle_outline;
      case 'pending':
      case 'waiting':
        return Icons.schedule_outlined;
      case 'cancelled':
      case 'rejected':
        return Icons.cancel_outlined;
      case 'in progress':
      case 'ongoing':
        return Icons.play_circle_outline;
      case 'rescheduled':
        return Icons.update_outlined;
      default:
        return Icons.info_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getColor();
    final iconData = _getIcon();

    Widget chipContent = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(borderRadius!),
        border: Border.all(
          color: color,
          width: borderWidth,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showIcon) ...[
            Icon(
              iconData,
              size: iconSize,
              color: color,
            ),
            const SizedBox(width: 4),
          ],
          Text(
            status.isNotEmpty
                ? '${status[0].toUpperCase()}${status.substring(1)}'
                : '',
            style: TextStyle(
              color: color,
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );

    if (onTap != null) {
      chipContent = GestureDetector(
        onTap: onTap,
        child: chipContent,
      );
    }

    return chipContent;
  }
}
