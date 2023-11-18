class Blog {
  String title;
  String content;
  String contentPreview;
  int likes;
  int comments;
  String author;

  // konstruktor
  Blog({required this.title, required this.content,required this.contentPreview, required this.likes, required this.comments, required this.author});

  @override
  String toString() {
    return 'Blog{title: $title, content: $content, likes: $likes, author: $author, comments: $comments}';
  }

}