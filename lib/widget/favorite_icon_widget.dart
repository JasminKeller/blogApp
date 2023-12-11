import 'package:flutter/material.dart';

class FavoriteIconWidget extends StatefulWidget {
  final int favoriteCount;
  final bool isFavorited;
  final ValueChanged<bool> onFavoriteChanged; // Callback

  const FavoriteIconWidget({
    super.key,
    required this.favoriteCount,
    required this.isFavorited,
    required this.onFavoriteChanged,
  });

  @override
  State<FavoriteIconWidget> createState() => _FavoriteIconWidgetState();
}

class _FavoriteIconWidgetState extends State<FavoriteIconWidget> {

  bool _isFavorited = false;
  int _favoriteCount = 0;


  @override
  void initState() {
    super.initState();
    _favoriteCount = widget.favoriteCount;
    _isFavorited = widget.isFavorited;
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorited = !_isFavorited;
      _favoriteCount = _isFavorited ? _favoriteCount + 1 : _favoriteCount - 1;
      widget.onFavoriteChanged(_isFavorited); // Callback aufrufen
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
      ],
    );
  }
}
