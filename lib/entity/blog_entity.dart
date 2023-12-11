class Blog {
  int id;
  String title;
  String content;
  String contentPreview;
  int likes;
  int comments;
  String author;
  DateTime publishedAt;
  bool isLikedByMe = false;

  // konstruktor
  Blog({
    this.id =0,
    required this.title,
    required this.content,
    this.likes = 0,
    this.comments = 0,
    required this.author,
    required this.publishedAt
  })  : contentPreview = content.length > 60 ? content.substring(0, 60) : content;

  @override
  String toString() {
    return 'Blog{id: $id, title: $title, content: $content, likes: $likes, author: $author, comments: $comments, Published at: $publishedAt}';
  }

  String get publishedDateString =>
      "${publishedAt.day}.${publishedAt.month}.${publishedAt.year}";

}