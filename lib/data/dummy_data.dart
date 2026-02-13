import '../models/product.dart';

const categories = [
  'Camera Drones',
  'Handheld',
  'Power',
  'Accessories',
  'Enterprise',
];

final products = <Product>[
  const Product(
    id: 'p1',
    name: 'Air Series Drone',
    category: 'Camera Drones',
    shortDesc: 'Cinematic drone with smart tracking.',
    description:
        'A cinematic drone built for smooth 4K footage, smart tracking, and stable flight. Perfect for creators.',
    price: 89999,
    rating: 4.6,
    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTLC-T_TOOjRrK10EemX4wD-5rQ2OI5rAc7SQ&s',
  ),
  const Product(
    id: 'p2',
    name: 'Mini Series Drone',
    category: 'Camera Drones',
    shortDesc: 'Lightweight drone for travel.',
    description:
        'Compact and travel-friendly drone with stabilized shots and easy controls. Great for beginners.',
    price: 59999,
    rating: 4.5,
    imageUrl: 'data:image/jpeg;base64,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',
  ),
  const Product(
    id: 'p3',
    name: 'Pro Gimbal',
    category: 'Handheld',
    shortDesc: 'Stabilizer for mobile filmmaking.',
    description:
        'Professional handheld gimbal for smooth video. Includes follow modes and quick setup.',
    price: 17999,
    rating: 4.4,
    imageUrl: 'https://png.pngtree.com/png-vector/20250215/ourmid/pngtree-gimbal-stabilizer-with-camera-transparency-background-png-image_15468459.png',
  ),
  const Product(
    id: 'p4',
    name: 'Fast Charger Hub',
    category: 'Power',
    shortDesc: 'Charge multiple batteries quickly.',
    description:
        'A fast multi-battery hub that optimizes charging and protects battery health.',
    price: 6999,
    rating: 4.3,
    imageUrl: 'https://picsum.photos/seed/charger/800/500',
  ),
  const Product(
    id: 'p5',
    name: 'Spare Propellers',
    category: 'Accessories',
    shortDesc: 'Low-noise propeller set.',
    description:
        'Durable, low-noise propellers designed for stable flight and easy replacement.',
    price: 1499,
    rating: 4.2,
    imageUrl: 'https://www.vhv.rs/dpng/d/551-5518862_plane-propeller-png-free-plane-propeller-transparent-airplane.png',
  ),
  const Product(
    id: 'p6',
    name: 'Enterprise Mapping Kit',
    category: 'Enterprise',
    shortDesc: 'Survey + mapping bundle.',
    description:
        'A mapping-ready bundle for enterprise use cases like inspection and surveying.',
    price: 229999,
    rating: 4.7,
    imageUrl: 'https://picsum.photos/seed/enterprise/800/500',
  ),
];

List<Product> productsByCategory(String category) =>
    products.where((p) => p.category == category).toList();

List<Product> searchProducts(String query) {
  final q = query.trim().toLowerCase();
  if (q.isEmpty) return products;
  return products.where((p) {
    return p.name.toLowerCase().contains(q) ||
        p.category.toLowerCase().contains(q) ||
        p.shortDesc.toLowerCase().contains(q);
  }).toList();
}
