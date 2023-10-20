class Question {
  final String category;
  final String question;
  final List<String> answer;

  Question({
    required this.category,
    required this.question,
    required this.answer,
  });

  Question.swift({
    required this.question,
    required this.answer,
  }) : category = "Swift";

  static List<Question> generate() {
    return [
      Question.swift(
        question: "커스텀 객체의 배열이 있을 때, 프로퍼티를 기준으로 배열을 어떻게 정렬할 수 있을까요?",
        answer: ["sorted 메서드에 직접 소팅 클로저를 지정해줄 수 있습니다."],
      ),
      Question.swift(
        question: "inout은 언제 사용하면 좋을까요?",
        answer: [
          "inout 파라미터를 사용하면 값 타입 변수가 저장된 주소의 값을 함수 안과 밖에서 동일하게 사용하게 됩니다. 따라서 함수가 입력과 동일한 출력을 제공하고, 함수 내에서 적용된 변경사항이 함수 외부에서도 동일하게 적용되어야할 때 사용할 수 있습니다.",
          "Swap을 직접 구현하고자 한다면 inout이 좋은 선택이 될 수 있습니다."
        ],
      ),
      Question.swift(
        question: "연산 프로퍼티와 클로저를 가지는 저장 프로퍼티의 차이를 설명해보세요.",
        answer: [
          "클로저를 가지는 저장 프로퍼티는 프로퍼티의 생성시점에 클로저를 생성하고 사용합니다.",
          "또한 var 키워드로 생성되어 있다면 다른 클로저를 할당해주는 것도 가능합니다.",
          "연산 프로퍼티는 프로퍼티를 참조할 때마다 클로저를 생성하고 실행합니다."
        ],
      ),
      Question.swift(
        question: "open과 public 키워드의 차이를 설명해보세요.",
        answer: [
          "open과 public 키워드 모두 외부 모듈에서의 접근까지 허용합니다.",
          "open은 클래스에서만 사용할 수 있습니다.",
          "open은 외부 모듈에서 클래스를 상속하는 것과 메소드 오버라이딩이 가능하지만, public은 외부 모듈에서의 클래스 상속과 메소드 오버라이딩을 제한합니다.",
          "동일한 모듈 내에서는 open과 public 모두 클래스 상속과 메소드 오버라이딩이 가능합니다."
        ],
      ),
      Question.swift(
        question: "커스텀 객체의 배열이 있을 때, 프로퍼티를 기준으로 배열을 어떻게 정렬할 수 있을까요?",
        answer: ["sorted 메서드에 직접 소팅 클로저를 지정해줄 수 있습니다."],
      ),
    ];
  }
}
