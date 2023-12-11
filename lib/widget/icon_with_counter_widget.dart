import 'package:flutter/material.dart';

import '../services/blog_repository.dart';

class IconWithCounterWidget extends StatefulWidget {
  final IconData icon;
  final int count;


  const IconWithCounterWidget({
    super.key, required this.icon, required this.count
  });

  @override
  _IconWithCounterWidgetState createState() => _IconWithCounterWidgetState();
}

class _IconWithCounterWidgetState extends State<IconWithCounterWidget> {
  late int count;
  final BlogRepository blogRepository = BlogRepository.instance;

  @override
  void initState() {
    super.initState();
    count = widget.count;
  }

  void _incrementCounter() {
    setState(() {
      count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: _incrementCounter,
          child: Icon(widget.icon),
        ),
        const SizedBox(width: 4),
        Text(count.toString()),
      ],
    );
  }
}
