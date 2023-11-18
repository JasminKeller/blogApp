import 'package:flutter/material.dart';
class IconWithCounterWidget extends StatelessWidget {
  final IconData icon;
  final int count;

  const IconWithCounterWidget({
    super.key, required this.icon, required this.count
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon),
        const SizedBox(width: 4),
        Text(count.toString()),
      ],
    );
  }
}