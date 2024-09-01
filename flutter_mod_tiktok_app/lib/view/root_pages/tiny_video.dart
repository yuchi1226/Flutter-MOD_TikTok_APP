import 'package:flutter/material.dart';

class TinyVideoPage extends StatefulWidget {
  const TinyVideoPage({super.key});

  @override
  State<TinyVideoPage> createState() => _TinyVideoPageState();
}

class _TinyVideoPageState extends State<TinyVideoPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('TinyVideoPage'),);
  }
}