///
/// Speech to Text의 음성 인식 상태
///
enum SpeechStatus {
  ready,      // 음성 인식을 시작할 준비가 된 상태
  listening,  // 음성 인식 중
  recognized, // 음성 인식 후 텍스트가 처리된 상태
}
