import 'product.dart';

class OrderItem {
  final Product product;
  final int qty;

  const OrderItem({required this.product, required this.qty});

  double get lineTotal => product.price * qty;
}

class Order {
  final String id;
  final DateTime createdAt;
  final List<OrderItem> items;
  final double total;

  const Order({
    required this.id,
    required this.createdAt,
    required this.items,
    required this.total,
  });
}
