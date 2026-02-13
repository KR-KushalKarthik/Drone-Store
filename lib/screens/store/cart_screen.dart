import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/cart_provider.dart';
import '../../providers/order_provider.dart';
import '../../models/order.dart';
import 'orders_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: cart.items.isEmpty
          ? const Center(child: Text('Your cart is empty'))
          : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: cart.items.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (_, i) {
                      final entry = cart.items.entries.elementAt(i);
                      final p = entry.key;
                      final qty = entry.value;

                      return Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey.shade200),
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(14),
                              child: Image.network(p.imageUrl, width: 70, height: 70, fit: BoxFit.cover),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(p.name, style: const TextStyle(fontWeight: FontWeight.w900)),
                                  const SizedBox(height: 4),
                                  Text('₹${p.price.toStringAsFixed(0)}', style: TextStyle(color: Colors.grey.shade700)),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () => context.read<CartProvider>().removeOne(p),
                                        icon: const Icon(Icons.remove_circle_outline),
                                      ),
                                      Text('$qty', style: const TextStyle(fontWeight: FontWeight.w900)),
                                      IconButton(
                                        onPressed: () => context.read<CartProvider>().add(p),
                                        icon: const Icon(Icons.add_circle_outline),
                                      ),
                                      const Spacer(),
                                      IconButton(
                                        onPressed: () => context.read<CartProvider>().delete(p),
                                        icon: const Icon(Icons.delete_outline),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                Container(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                  decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.grey.shade200)),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Text('Subtotal', style: TextStyle(fontWeight: FontWeight.w800)),
                          const Spacer(),
                          Text('₹${cart.subtotal.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.w900)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: () {
                            final items = cart.items.entries
                                .map((e) => OrderItem(product: e.key, qty: e.value))
                                .toList();

                            final order = Order(
                              id: DateTime.now().millisecondsSinceEpoch.toString(),
                              createdAt: DateTime.now(),
                              items: items,
                              total: cart.subtotal,
                            );

                            context.read<OrderProvider>().addOrder(order);
                            cart.clear();

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => const OrdersScreen()),
                            );
                          },
                          child: const Text('Place Order'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
