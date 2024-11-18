import 'package:flutter/material.dart';
import 'package:flutter_app/features/Quran/view_quran/model/quran_model.dart';

class SurahDetailScreen extends StatefulWidget {
  final List<Ayah> ayah;
  const SurahDetailScreen({super.key, required this.ayah});

  @override
  State<SurahDetailScreen> createState() => _SurahDetailScreenState();
}

class _SurahDetailScreenState extends State<SurahDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
