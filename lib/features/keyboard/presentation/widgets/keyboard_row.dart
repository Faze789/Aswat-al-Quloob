import 'package:flutter/material.dart';

class KeyboardRow extends StatelessWidget {
  final List<Widget> keys;

  const KeyboardRow({super.key, required this.keys});

  @override
  Widget build(BuildContext context) {
    return Row(children: keys);
  }
}
