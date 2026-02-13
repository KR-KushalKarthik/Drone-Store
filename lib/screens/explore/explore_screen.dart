import 'package:flutter/material.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = <_ExploreCardData>[
      _ExploreCardData(
        tag: 'Newly Upgraded',
        title: 'Virtual Flight',
        subtitle: 'Practice before Flying',
        assetPath: 'assets/explore/virtual_flight.jpg',
        icon: Icons.airplanemode_active,
      ),
      _ExploreCardData(
        title: 'DJI FORUM',
        subtitle: 'Share your product experience,\nparticipate in our Q&A, and help\nDJI to grow.',
        assetPath: 'assets/explore/dji_forum.jpg',
        icon: Icons.chat_bubble_outline,
      ),
      _ExploreCardData(
        title: 'SkyPixel',
        subtitle: 'Share ideas with aerial\nphotographers, upload your\nwork, and test new products.',
        assetPath: 'assets/explore/skypixel.jpg',
        icon: Icons.camera_alt_outlined,
      ),
      _ExploreCardData(
        title: 'Academy',
        subtitle: 'Get started easily and learn\ncreative techniques that let you\nfilm like a pro.',
        assetPath: 'assets/explore/academy.jpg',
        icon: Icons.school_outlined,
      ),
    ];

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top title area like DJI
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
              child: Text(
                'Explore',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: Colors.grey.shade900,
                ),
              ),
            ),

            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                itemCount: items.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, i) {
                  final d = items[i];
                  return _ExploreCard(
                    data: d,
                    onTap: () {
                      // TODO: Navigate to your pages
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Open: ${d.title}')),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExploreCardData {
  final String title;
  final String subtitle;
  final String assetPath;
  final IconData icon;
  final String? tag;

  _ExploreCardData({
    required this.title,
    required this.subtitle,
    required this.assetPath,
    required this.icon,
    this.tag,
  });
}

class _ExploreCard extends StatelessWidget {
  final _ExploreCardData data;
  final VoidCallback onTap;

  const _ExploreCard({required this.data, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Ink(
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: AssetImage(data.assetPath),
            fit: BoxFit.cover,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              // dark overlay like DJI cards
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.black.withOpacity(0.60),
                      Colors.black.withOpacity(0.25),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),

              if (data.tag != null)
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE24B4B),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      data.tag!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),

              // icon circle (left)
              Positioned(
                left: 14,
                top: 0,
                bottom: 0,
                child: Center(
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(color: Colors.white.withOpacity(0.25)),
                    ),
                    child: Icon(data.icon, color: Colors.white),
                  ),
                ),
              ),

              // text (left)
              Positioned(
                left: 70,
                right: 12,
                top: 0,
                bottom: 0,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.2,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        data.subtitle,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.88),
                          fontSize: 12,
                          height: 1.25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
