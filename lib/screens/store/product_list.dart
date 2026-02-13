import 'package:flutter/material.dart';
import '../../data/dummy_data.dart';
import '../../models/product.dart';
import 'product_detail.dart';

class ProductListScreen extends StatefulWidget {
  final String? category;
  final String? openProductId;

  const ProductListScreen({super.key, this.category, this.openProductId});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  String q = '';

  @override
  void initState() {
    super.initState();
    if (widget.openProductId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final p = products.firstWhere((e) => e.id == widget.openProductId);
        Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailScreen(product: p)));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final list = (widget.category == null ? products : productsByCategory(widget.category!))
        .where((p) => p.name.toLowerCase().contains(q.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category ?? 'All Products'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
            child: TextField(
              onChanged: (v) => setState(() => q = v),
              decoration: InputDecoration(
                hintText: 'Search in this list...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
              itemCount: list.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (_, i) => _row(context, list[i]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _row(BuildContext context, Product p) {
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailScreen(product: p))),
      borderRadius: BorderRadius.circular(16),
      child: Ink(
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
              child: Image.network(p.imageUrl, width: 78, height: 78, fit: BoxFit.cover),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(p.name, style: const TextStyle(fontWeight: FontWeight.w900)),
                  const SizedBox(height: 4),
                  Text(p.shortDesc, style: TextStyle(color: Colors.grey.shade700, fontSize: 12)),
                  const SizedBox(height: 6),
                  Text('₹${p.price.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.w800)),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey.shade500),
          ],
        ),
      ),
    );
  }
}
