import 'package:flutter/foundation.dart';

class Blog {
  String id;
  String title;
  String content;
  String contentPreview;
  int likes;
  int comments;
  String author;
  DateTime publishedAt;
  bool isLikedByMe = false;
  String? headerImageUrl;

  // konstruktor
  Blog({
    required this.id,
    required this.title,
    required this.content,
    this.likes = 0,
    this.comments = 0,
    this.author = 'unknown',
    this.headerImageUrl,
    required this.publishedAt,
  })  : contentPreview = content.length > 60 ? content.substring(0, 60) : content;

  String get publishedDateString =>
      "${publishedAt.day}.${publishedAt.month}.${publishedAt.year}";


  factory Blog.fromJson(Map<String, dynamic> json) {
    try {
      return Blog(
        id: json['\$id'] as String,
        title: json['title'] as String,
        content: json['content'] as String,
        headerImageUrl: json['headerImageUrl'] as String?,
        publishedAt: DateTime.parse(json['\$createdAt'] as String),
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error parsing Blog from JSON: $e');
      }
      throw FormatException('Failed to load blog: ${json.toString()}');
    }
  }

  /* Mögliche Varianten
  factory Blog.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
      '\$id': String id,
      'title': String title,
      'content': String content,
      'headerImageUrl': String? headerImageUrl,
      'publishedAt': String publishedAt,
      } =>
          Blog(
            id: id,
            title: title,
            content: content,
            headerImageUrl: headerImageUrl,
            publishedAt: DateTime.parse(json['\$createdAt']),
          ),
      _ => throw const FormatException('Failed to load blogs.'),
    };
  }

 factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      id: json['\$id'],
      title: json['title'],
      content: json['content'],
      headerImageUrl: json['headerImageUrl'],
      publishedAt: DateTime.parse(json['\$createdAt']),
      userIdsWithLikes: json['userIdsWithLikes'] != null
          ? List<String>.from(json['userIdsWithLikes'])
          : null,
    );
  }

 */

  @override
  String toString() {
    return 'Blog{id: $id, title: $title, content: $content, likes: $likes, author: $author, comments: $comments, Published at: $publishedAt}';
  }

}