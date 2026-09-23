import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Future<void> showWorkingHoursRangePicker({
  required BuildContext context,
  required TimeOfDay initialStart,
  required TimeOfDay initialEnd,
  required Function(TimeOfDay start, TimeOfDay end) onTimePicked,
}) async {
  final pickedStart = await showTimePicker(
    context: context,
    initialTime: initialStart,
    helpText: 'start_time'.tr(),
  );

  if (pickedStart != null && context.mounted) {
    final pickedEnd = await showTimePicker(
      context: context,
      initialTime: initialEnd,
      helpText: 'end_time'.tr(),
    );

    if (pickedEnd != null) {
      onTimePicked(pickedStart, pickedEnd);
    }
  }
}