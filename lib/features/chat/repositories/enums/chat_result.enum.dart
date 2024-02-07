enum ChatResult {
  pass,
  failed;

  bool get isPassed => this == ChatResult.pass;
}
