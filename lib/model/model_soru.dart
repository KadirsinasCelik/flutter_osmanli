class Soru {
  final String title;
  final Map<String, bool> options;

  Soru({required this.title, required this.options});

  factory Soru.fromJson(Map<String, dynamic> json) {
    return Soru(
      title: json['title'],
      options: Map<String, bool>.from(json['options']),
    );
  }

  @override
  String toString() {
    return 'Question(title: $title, options: $options)';
  }

  void add(Soru newQuestion) {}
}
