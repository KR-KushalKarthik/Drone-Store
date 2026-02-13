import 'package:flutter/material.dart';
import '../store/store_home.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // For now Home uses StoreHome UI.
    return const StoreHome();
  }
}
