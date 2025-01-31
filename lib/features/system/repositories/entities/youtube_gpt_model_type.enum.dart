enum YoutubeGptModelType {
  gpt4o('gpt-4o'),
  o1('o1');

  final String id;

  const YoutubeGptModelType(this.id);

  static YoutubeGptModelType getById(String id) {
    return values.firstWhere(
      (topic) => topic.id == id,
      orElse: () => YoutubeGptModelType.gpt4o,
    );
  }

  bool get isGpt4o => this == YoutubeGptModelType.gpt4o;
}
