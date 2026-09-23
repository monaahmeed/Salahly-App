import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:salahly/core/theme/app_theme.dart';

class WorkRadiusDialog extends StatefulWidget {
  final double initialRadius;
  final ValueChanged<double> onSaved;

  const WorkRadiusDialog({
    super.key,
    required this.initialRadius,
    required this.onSaved,
  });

  @override
  State<WorkRadiusDialog> createState() => _WorkRadiusDialogState();
}

class _WorkRadiusDialogState extends State<WorkRadiusDialog> {
  late double _tempRadius;

  @override
  void initState() {
    super.initState();
    _tempRadius = widget.initialRadius;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(
        'select_radius'.tr(),
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppTheme.primaryNavy,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${_tempRadius.toInt()} ${'km_unit'.tr()}',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppTheme.accentAmber,
            ),
          ),
          Slider(
            value: _tempRadius,
            min: 5,
            max: 50,
            divisions: 9,
            activeColor: AppTheme.primaryNavy,
            inactiveColor: const Color(0xFFE2E8F0),
            onChanged: (val) => setState(() => _tempRadius = val),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('cancel'.tr(), style: const TextStyle(color: AppTheme.slate500)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primaryNavy,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          onPressed: () {
            widget.onSaved(_tempRadius);
            Navigator.pop(context);
          },
          child: Text('save'.tr(), style: const TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}