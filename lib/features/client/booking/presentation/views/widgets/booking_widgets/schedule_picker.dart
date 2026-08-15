import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:salahly/core/theme/app_theme.dart';
import 'package:salahly/features/client/booking/presentation/views/widgets/booking_widgets/date_picker_button.dart';
import 'package:salahly/features/client/booking/presentation/views/widgets/booking_widgets/option_button.dart';


class SchedulePicker extends StatefulWidget {
  final Function(DateTime selectedDate) onDateSelected;

  const SchedulePicker({
    super.key,
    required this.onDateSelected,
  });

  @override
  State<SchedulePicker> createState() => _SchedulePickerState();
}

class _SchedulePickerState extends State<SchedulePicker> {
  String _selectedOption = 'today';
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'when_title'.tr(),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryNavy,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            
            Expanded(
              child: OptionButton(
                label: 'today'.tr(),
                isSelected: _selectedOption == 'today',
                onTap: () {
                  setState(() {
                    _selectedOption = 'today';
                    _selectedDate = DateTime.now();
                  });
                  widget.onDateSelected(_selectedDate);
                },
              ),
            ),
            const SizedBox(width: 8),

            
            Expanded(
              child: OptionButton(
                label: 'tomorrow'.tr(),
                isSelected: _selectedOption == 'tomorrow',
                onTap: () {
                  setState(() {
                    _selectedOption = 'tomorrow';
                    _selectedDate = DateTime.now().add(const Duration(days: 1));
                  });
                  widget.onDateSelected(_selectedDate);
                },
              ),
            ),
            const SizedBox(width: 8),

            
            Expanded(
              child: DatePickerButton(
                isSelected: _selectedOption == 'custom',
                selectedDate: _selectedDate,
                onDatePicked: (pickedDate) {
                  setState(() {
                    _selectedOption = 'custom';
                    _selectedDate = pickedDate;
                  });
                  widget.onDateSelected(_selectedDate);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}