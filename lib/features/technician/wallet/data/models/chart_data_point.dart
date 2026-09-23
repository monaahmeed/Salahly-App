class ChartDataPoint {
  final String label;
  final double amount;
  final bool isCurrent;

  const ChartDataPoint({
    required this.label,
    required this.amount,
    this.isCurrent = false,
  });
}