import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/dummy_data.dart';
import '../../providers/cart_provider.dart';
import 'cart_screen.dart';
import 'product_list.dart';

class StoreHome extends StatefulWidget {
  const StoreHome({super.key});

  @override
  State<StoreHome> createState() => _StoreHomeState();
}

class _StoreHomeState extends State<StoreHome> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
              child: Row(
                children: [
                  const Icon(Icons.menu),
                  const SizedBox(width: 12),
                  Text('STORE', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1.2, color: Colors.grey.shade900)),
                  const Spacer(),
                  Stack(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen()));
                        },
                        icon: const Icon(Icons.shopping_cart_outlined),
                      ),
                      if (cart.totalItems > 0)
                        Positioned(
                          right: 6,
                          top: 6,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text('${cart.totalItems}', style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                          ),
                        )
                    ],
                  ),
                ],
              ),
            ),
          ),

          // search
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: TextField(
                onChanged: (v) => setState(() => query = v),
                decoration: InputDecoration(
                  hintText: 'Search products...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                ),
              ),
            ),
          ),

          // banners
          SliverToBoxAdapter(
            child: CarouselSlider(
              options: CarouselOptions(height: 180, autoPlay: true, viewportFraction: 0.92, enlargeCenterPage: true),
              items: [
                _banner('Early Access', 'New products at launch', 'https://picsum.photos/seed/banner1/900/500'),
                _banner('Member Benefits', 'Rewards & offers', 'https://picsum.photos/seed/banner2/900/500'),
                _banner('Virtual Flight', 'Practice before you fly', 'https://png.pngtree.com/png-vector/20241022/ourmid/pngtree-drone-camera-png-image_14144053.png'),
              ],
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 14)),

          // Categories
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const Text('Categories', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
                  const Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: const Text('See all'),
                  ),
                ],
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, i) {
                  final c = categories[i];
                  return InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => ProductListScreen(category: c)));
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: Ink(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade200),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
                              child: const Icon(Icons.category_outlined),
                            ),
                            const SizedBox(width: 12),
                            Expanded(child: Text(c, style: const TextStyle(fontWeight: FontWeight.w800))),
                            Icon(Icons.chevron_right, color: Colors.grey.shade500),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                childCount: categories.length,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 1.6,
              ),
            ),
          ),

          // Featured (search-aware)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Text(query.trim().isEmpty ? 'Featured' : 'Results', style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
                  const Spacer(),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: SizedBox(
              height: 260,
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, i) {
                  final list = searchProducts(query);
                  final p = list[i];
                  return _productCard(context, p);
                },
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemCount: searchProducts(query).length.clamp(0, 10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _banner(String title, String subtitle, String url) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(url, fit: BoxFit.cover),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter, end: Alignment.topCenter,
                colors: [Colors.black.withOpacity(0.55), Colors.transparent],
              ),
            ),
          ),
          Positioned(
            left: 16, right: 16, bottom: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 18)),
                const SizedBox(height: 4),
                Text(subtitle, style: TextStyle(color: Colors.white.withOpacity(0.9), fontWeight: FontWeight.w600, fontSize: 13)),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _productCard(BuildContext context, dynamic p) {
    // p is Product but keeping simple
    return SizedBox(
      width: 190,
      child: InkWell(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductListScreen(openProductId: p.id))),
        borderRadius: BorderRadius.circular(18),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.grey.shade200),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
                child: Image.network(p.imageUrl, height: 120, width: double.infinity, fit: BoxFit.cover),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(p.name, style: const TextStyle(fontWeight: FontWeight.w900)),
                    const SizedBox(height: 6),
                    Text('₹${p.price.toStringAsFixed(0)}', style: TextStyle(color: Colors.grey.shade700)),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () {
                          context.read<CartProvider>().add(p);
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Added to cart')));
                        },
                        child: const Text('Add'),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
