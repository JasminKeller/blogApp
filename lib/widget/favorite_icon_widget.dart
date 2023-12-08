import 'package:flutter/material.dart';

class FavoriteWidget extends StatefulWidget {
  final int favoriteCount;
  final int commentCount;

  const FavoriteWidget({super.key, required this.favoriteCount, required this.commentCount});

  @override
  State<FavoriteWidget> createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {

  bool _isFavorited = false;
  int _favoriteCount = 0;

  @override
  void initState() {
    super.initState();
    _favoriteCount = widget.favoriteCount;
  }

  void _toggleFavorite() {
    setState(() {
      if (_isFavorited) {
        _favoriteCount -= 1;
        _isFavorited = false;
      } else {
        _favoriteCount += 1;
        _isFavorited = true;
      }
    });
  }

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
            icon: (_isFavorited
                ? const Icon(Icons.favorite)
                : const Icon(Icons.favorite_border)),
            color: Colors.red[500],
            onPressed: _toggleFavorite,
          ),
        ),
        SizedBox(
          width: 30,
          child: SizedBox(
            child: Text('$_favoriteCount'),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(0),
          child: IconButton(
            padding: const EdgeInsets.all(0),
            alignment: Alignment.centerRight,
            icon: (_isFavorited
                ? const Icon(Icons.mode_comment_outlined)
                : const Icon(Icons.mode_comment_outlined)),
            onPressed: _toggleFavorite,
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
