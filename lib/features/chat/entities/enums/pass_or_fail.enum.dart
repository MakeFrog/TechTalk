enum PassOrFail {
  pass,
  failed;

  bool get isPassed => this == PassOrFail.pass;
}
