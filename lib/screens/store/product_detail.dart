import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/product.dart';
import '../../providers/cart_provider.dart';
import 'cart_screen.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final qty = cart.qty(product);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen())),
            icon: Stack(
              children: [
                const Icon(Icons.shopping_cart_outlined),
                if (cart.totalItems > 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(999)),
                      child: Text('${cart.totalItems}', style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                    ),
                  )
              ],
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          Image.network(product.imageUrl, height: 220, width: double.infinity, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18)),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text('₹${product.price.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
                    const Spacer(),
                    Row(
                      children: [
                        const Icon(Icons.star, size: 18),
                        const SizedBox(width: 4),
                        Text(product.rating.toStringAsFixed(1), style: const TextStyle(fontWeight: FontWeight.w800)),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 12),
                Text(product.description, style: TextStyle(color: Colors.grey.shade800, height: 1.35)),
                const SizedBox(height: 18),

                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade200),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      const Text('Quantity', style: TextStyle(fontWeight: FontWeight.w900)),
                      const Spacer(),
                      IconButton(
                        onPressed: qty > 0 ? () => context.read<CartProvider>().removeOne(product) : null,
                        icon: const Icon(Icons.remove_circle_outline),
                      ),
                      Text('$qty', style: const TextStyle(fontWeight: FontWeight.w900)),
                      IconButton(
                        onPressed: () => context.read<CartProvider>().add(product),
                        icon: const Icon(Icons.add_circle_outline),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 14),

                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {
                      context.read<CartProvider>().add(product);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Added to cart')));
                    },
                    child: const Text('Add to Cart'),
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
