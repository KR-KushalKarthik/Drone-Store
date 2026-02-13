import 'package:flutter/foundation.dart';
import '../models/product.dart';

class CartProvider extends ChangeNotifier {
  final Map<String, int> _qtyByProductId = {};
  final Map<String, Product> _productById = {};

  Map<Product, int> get items => {
        for (final id in _qtyByProductId.keys) _productById[id]!: _qtyByProductId[id]!,
      };

  int qty(Product p) => _qtyByProductId[p.id] ?? 0;

  int get totalItems => _qtyByProductId.values.fold(0, (a, b) => a + b);

  double get subtotal {
    double sum = 0;
    for (final entry in items.entries) {
      sum += entry.key.price * entry.value;
    }
    return sum;
  }

  void add(Product p) {
    _productById[p.id] = p;
    _qtyByProductId[p.id] = (_qtyByProductId[p.id] ?? 0) + 1;
    notifyListeners();
  }

  void removeOne(Product p) {
    final current = _qtyByProductId[p.id] ?? 0;
    if (current <= 1) {
      _qtyByProductId.remove(p.id);
      _productById.remove(p.id);
    } else {
      _qtyByProductId[p.id] = current - 1;
    }
    notifyListeners();
  }

  void delete(Product p) {
    _qtyByProductId.remove(p.id);
    _productById.remove(p.id);
    notifyListeners();
  }

  void clear() {
    _qtyByProductId.clear();
    _productById.clear();
    notifyListeners();
  }
}
