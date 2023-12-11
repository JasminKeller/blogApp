import 'package:flutter/material.dart';

class CommentIconWidget extends StatefulWidget {
  final int commentCount;

  const CommentIconWidget({super.key, required this.commentCount});

  @override
  State<CommentIconWidget> createState() => _CommentIconWidgetState();
}

class _CommentIconWidgetState extends State<CommentIconWidget> {


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(0),
          child: IconButton(
            padding: const EdgeInsets.all(0),
            alignment: Alignment.centerRight,
            icon: (const Icon(Icons.mode_comment_outlined)),
            onPressed: () {  },
          ),
        ),
        SizedBox(
          width: 6,
          child: SizedBox(
            child: Text('${widget.commentCount}'),
          ),
        ),
      ],
    );
  }
}
