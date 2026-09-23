enum PaymentMethod { cash, card, wallet }

class SparePartItem {
  final String name;
  final double price;

  const SparePartItem({required this.name, required this.price});
}

class InvoiceModel {
  final String bookingId;
  final String technicianName;
  final String serviceTitle;
  final double laborCost;
  final List<SparePartItem> spareParts;
  final double tax;
  final double discount;

  const InvoiceModel({
    required this.bookingId,
    required this.technicianName,
    required this.serviceTitle,
    required this.laborCost,
    this.spareParts = const [],
    this.tax = 0.0,
    this.discount = 0.0,
  });

  double get sparePartsTotal =>
      spareParts.fold(0.0, (sum, item) => sum + item.price);

  double get totalAmount => (laborCost + sparePartsTotal + tax) - discount;
}