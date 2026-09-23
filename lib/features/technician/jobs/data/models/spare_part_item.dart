class SparePartItem {
  final String id;
  final String name;
  final double price;
  final int quantity;

  const SparePartItem({
    required this.id,
    required this.name,
    required this.price,
    this.quantity = 1,
  });

  double get totalPrice => price * quantity;
}