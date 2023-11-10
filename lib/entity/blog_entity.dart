class Blog {
  String title;
  String content;

  // konstruktor
  Blog({required this.title, required this.content});

  @override
  String toString() {
    return 'Blog{title: $title, content: $content}';
  }

}