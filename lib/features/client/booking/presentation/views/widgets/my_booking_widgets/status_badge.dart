import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

enum BookingStatus { inProgress, pending, scheduled, completed, cancelled }

class StatusBadge extends StatelessWidget {
  final BookingStatus status;

  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;
    String labelKey;

    switch (status) {
      case BookingStatus.inProgress:
        bgColor = const Color(0xFFE6F4EA);
        textColor = const Color(0xFF137333);
        labelKey = 'in_progress';
        break;
      case BookingStatus.pending:
        bgColor = const Color(0xFFFEF7E0);
        textColor = const Color(0xFFB06000);
        labelKey = 'pending';
        break;
      case BookingStatus.scheduled:
        bgColor = const Color(0xFFF1F3F4);
        textColor = const Color(0xFF5F6368);
        labelKey = 'scheduled';
        break;
      case BookingStatus.completed:
        bgColor = const Color(0xFFE8F0FE);
        textColor = const Color(0xFF1A73E8);
        labelKey = 'completed';
        break;
      case BookingStatus.cancelled:
        bgColor = const Color(0xFFFCE8E6);
        textColor = const Color(0xFFC5221F);
        labelKey = 'cancelled';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (status == BookingStatus.inProgress) ...[
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: textColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 4),
          ],
          Text(
            labelKey.tr(),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}