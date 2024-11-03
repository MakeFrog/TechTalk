enum ContentsLanguage {
  english(id: 'english', displayStr: '영어'),
  korean(id: 'korean', displayStr: '한국어');

  final String id;
  final String displayStr;

  const ContentsLanguage({required this.id, required this.displayStr});
}
