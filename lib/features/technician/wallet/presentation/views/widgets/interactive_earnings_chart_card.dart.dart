import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:salahly/core/theme/app_theme.dart';
import 'package:salahly/features/technician/wallet/data/models/chart_data_point.dart';

enum EarningsFilterPeriod { week, month, year }

class InteractiveEarningsChartCard extends StatefulWidget {
  const InteractiveEarningsChartCard({super.key});

  @override
  State<InteractiveEarningsChartCard> createState() =>
      _InteractiveEarningsChartCardState();
}

class _InteractiveEarningsChartCardState
    extends State<InteractiveEarningsChartCard> {
  EarningsFilterPeriod _selectedPeriod = EarningsFilterPeriod.week;
  int? _selectedBarIndex;

  @override
  void initState() {
    super.initState();
    _setInitialCurrentSelection();
  }

  void _setInitialCurrentSelection() {
    final data = _getCurrentData();
    final currentIndex = data.indexWhere((point) => point.isCurrent);
    _selectedBarIndex = currentIndex != -1 ? currentIndex : null;
  }

  List<ChartDataPoint> _getCurrentData() {
    final now = DateTime.now();

    switch (_selectedPeriod) {
      case EarningsFilterPeriod.week:
        final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
        final currentWeekdayIndex = now.weekday - 1; // 0-based
        final mockWeekAmounts = [350.0, 720.0, 240.0, 950.0, 600.0, 0.0, 0.0];

        return List.generate(7, (i) {
          return ChartDataPoint(
            label: days[i],
            amount: mockWeekAmounts[i],
            isCurrent: i == currentWeekdayIndex,
          );
        });

      case EarningsFilterPeriod.month:
        final currentWeek = ((now.day - 1) / 7).floor();
        final mockMonthAmounts = [2400.0, 3150.0, 1850.0, 4200.0];

        return List.generate(4, (i) {
          return ChartDataPoint(
            label: 'W${i + 1}',
            amount: mockMonthAmounts[i],
            isCurrent: i == currentWeek,
          );
        });

      case EarningsFilterPeriod.year:
        final months = [
          'Jan',
          'Feb',
          'Mar',
          'Apr',
          'May',
          'Jun',
          'Jul',
          'Aug',
          'Sep',
          'Oct',
          'Nov',
          'Dec',
        ];
        final currentMonthIndex = now.month - 1;
        final mockYearAmounts = [
          4500.0,
          6200.0,
          5800.0,
          7100.0,
          8900.0,
          9400.0,
          8100.0,
          10500.0,
          0.0,
          0.0,
          0.0,
          0.0,
        ];

        return List.generate(12, (i) {
          return ChartDataPoint(
            label: months[i],
            amount: mockYearAmounts[i],
            isCurrent: i == currentMonthIndex,
          );
        });
    }
  }

  String _getPeriodTitle() {
    switch (_selectedPeriod) {
      case EarningsFilterPeriod.week:
        return 'weekly_earnings'.tr();
      case EarningsFilterPeriod.month:
        return 'monthly_earnings'.tr();
      case EarningsFilterPeriod.year:
        return 'yearly_earnings'.tr();
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = _getCurrentData();
    final maxAmount = data.map((e) => e.amount).reduce((a, b) => a > b ? a : b);
    final normalizedMax = maxAmount == 0 ? 1000.0 : maxAmount * 1.25;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFF1F5F9)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _getPeriodTitle(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryNavy,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<EarningsFilterPeriod>(
                    value: _selectedPeriod,
                    icon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 18,
                      color: AppTheme.primaryNavy,
                    ),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryNavy,
                    ),
                    onChanged: (period) {
                      if (period != null) {
                        setState(() {
                          _selectedPeriod = period;
                          _setInitialCurrentSelection();
                        });
                      }
                    },
                    items: [
                      DropdownMenuItem(
                        value: EarningsFilterPeriod.week,
                        child: Text('this_week'.tr()),
                      ),
                      DropdownMenuItem(
                        value: EarningsFilterPeriod.month,
                        child: Text('this_month'.tr()),
                      ),
                      DropdownMenuItem(
                        value: EarningsFilterPeriod.year,
                        child: Text('this_year'.tr()),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),

          SizedBox(
            height: 180,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
               
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _formatAxisNumber(normalizedMax),
                      style: const TextStyle(
                        fontSize: 10,
                        color: Color(0xFF94A3B8),
                      ),
                    ),
                    Text(
                      _formatAxisNumber(normalizedMax * 0.66),
                      style: const TextStyle(
                        fontSize: 10,
                        color: Color(0xFF94A3B8),
                      ),
                    ),
                    Text(
                      _formatAxisNumber(normalizedMax * 0.33),
                      style: const TextStyle(
                        fontSize: 10,
                        color: Color(0xFF94A3B8),
                      ),
                    ),
                    const Text(
                      '0',
                      style: TextStyle(fontSize: 10, color: Color(0xFF94A3B8)),
                    ),
                  ],
                ),
                const SizedBox(width: 8),

                // 2️⃣ الأعمدة مع التمرير الأفقي السلس (Scrollable Bars)
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: List.generate(data.length, (index) {
                        final item = data[index];
                        final barHeight = (item.amount / normalizedMax * 120)
                            .clamp(6.0, 120.0);
                        final isSelected = _selectedBarIndex == index;
                        final isCurrent = item.isCurrent;

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedBarIndex = isSelected ? null : index;
                              });
                            },
                            behavior: HitTestBehavior.opaque,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // فقاعة الـ Tooltip
                                AnimatedOpacity(
                                  duration: const Duration(milliseconds: 150),
                                  opacity: isSelected && item.amount > 0
                                      ? 1.0
                                      : 0.0,
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 6),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 3,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF1E293B),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Text(
                                      '${'egp'.tr()} ${item.amount.toStringAsFixed(0)}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),

                                // العمود
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 250),
                                  width: 24,
                                  height: barHeight,
                                  decoration: BoxDecoration(
                                    color: isCurrent
                                        ? const Color(0xFFF59E0B)
                                        : (isSelected
                                              ? const Color(0xFFCBD5E1)
                                              : const Color(0xFFE2E8F0)),
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(5),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),

                                Text(
                                  item.label,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: isCurrent
                                        ? FontWeight.bold
                                        : FontWeight.w500,
                                    color: isCurrent
                                        ? AppTheme.primaryNavy
                                        : const Color(0xFF94A3B8),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatAxisNumber(double value) {
    if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(1).replaceAll('.0', '')}k';
    }
    return value.toStringAsFixed(0);
  }
}
