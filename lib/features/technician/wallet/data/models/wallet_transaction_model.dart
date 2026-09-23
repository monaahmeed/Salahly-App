class WalletTransactionModel {
  final String id;
  final String title;
  final String referenceNumber;
  final String dateText;
  final double amount;
  final bool isCashInflow;

  const WalletTransactionModel({
    required this.id,
    required this.title,
    required this.referenceNumber,
    required this.dateText,
    required this.amount,
    this.isCashInflow = true,
  });
}