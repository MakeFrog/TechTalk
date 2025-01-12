import 'package:techtalk/features/chat/repositories/entities/base_qna_entity.dart';
import 'package:techtalk/features/chat/repositories/enums/qna_type.enum.dart';
import 'package:techtalk/features/chat/repositories/enums/resume_question_type.enum.dart';

final List<ResumeQnaEntity> tempResumeQnaList = [
  // 하드스킬 질문 1
  ResumeQnaEntity(
    id: 'resume-1',
    question: '중고나라 앱에서 딥링크 구조를 개선한 작업에서 가장 큰 도전 과제와 이를 해결하기 위한 접근법은 무엇인가요?',
    questionType: ResumeQuestionType.hardSkill,
    evaluationPoint: '문제 정의 및 해결 능력, 추상화 설계 경험, 코드 개선의 실질적 효과',
  ),
  // 하드스킬 질문 2
  ResumeQnaEntity(
    id: 'resume-2',
    question:
        'Firebase A/B 테스트를 활용해 광고 매출을 12.4% 증가시켰다고 했는데, 실험 설계와 데이터 분석 과정은 어떻게 진행되었나요?',
    questionType: ResumeQuestionType.hardSkill,
    evaluationPoint: 'Firebase 기능 활용 능력, 실험 설계 및 데이터 기반 의사결정 역량',
  ),
  // 하드스킬 질문 3
  ResumeQnaEntity(
    id: 'resume-3',
    question:
        'Pets Next Door 프로젝트에서 Riverpod와 Clean Architecture를 결합하여 얻은 주요 성과는 무엇인가요?',
    questionType: ResumeQuestionType.hardSkill,
    evaluationPoint: '상태 관리와 아키텍처 설계에 대한 이해, 실무 적용 능력, 협업 및 코드 유지보수성',
  ),
  // // 하드스킬 질문 4
  // ResumeQnaEntity(
  //   id: 'resume-4',
  //   question:
  //       'Flutter와 네이티브 코드를 통합하여 로그인 기능을 구현할 때 어떤 접근을 사용했으며, 이를 통해 얻은 결과는 무엇인가요?',
  //   questionType: ResumeQuestionType.hardSkill,
  //   evaluationPoint:
  //       'Flutter와 네이티브 코드 통합 기술, Firebase Auth 활용 능력, 테스트 코드 작성 및 검증 경험',
  // ),
  // // 하드스킬 질문 5
  // ResumeQnaEntity(
  //   id: 'resume-5',
  //   question: 'go_router를 활용한 Nested Navigation을 구현하며 겪은 기술적 도전과 해결 방법은 무엇인가요?',
  //   questionType: ResumeQuestionType.hardSkill,
  //   evaluationPoint: '복잡한 네비게이션 구현 능력, 코드 구조 개선 및 문제 해결 능력',
  // ),
  // // 소프트스킬 질문 1
  // ResumeQnaEntity(
  //   id: 'resume-6',
  //   question: '협업 과정에서 겪은 가장 어려운 상황과 이를 해결하기 위해 사용한 방법은 무엇인가요?',
  //   questionType: ResumeQuestionType.softSkill,
  //   evaluationPoint: '팀워크 및 커뮤니케이션 능력, 갈등 해결 및 문제 극복 역량',
  // ),
  // // 소프트스킬 질문 2
  // ResumeQnaEntity(
  //   id: 'resume-7',
  //   question: '"기획 변경에도 유연하게 대처할 수 있는 코드를 작성했다"고 했는데, 이를 위해 어떤 노력을 기울였나요?',
  //   questionType: ResumeQuestionType.softSkill,
  //   evaluationPoint: '변화에 적응할 수 있는 유연성, 코드 품질과 설계 역량',
  // ),
  // 소프트스킬 질문 3
  ResumeQnaEntity(
    id: 'resume-8',
    question: '블로그나 오픈소스 프로젝트를 통해 다른 개발자들에게 긍정적인 영향을 준 사례를 소개해주세요.',
    questionType: ResumeQuestionType.softSkill,
    evaluationPoint: '커뮤니티 기여 경험, 지식 공유에 대한 열정 및 지속적 학습 태도',
  ),
  // 소프트스킬 질문 4
  ResumeQnaEntity(
    id: 'resume-9',
    question: 'Flutter와 관련된 최신 기술 트렌드를 어떻게 파악하고, 실무에 적용했는지 설명해주세요.',
    questionType: ResumeQuestionType.softSkill,
    evaluationPoint: '자기 주도 학습 능력, 최신 기술 도입 및 적용 능력',
  ),
  // 소프트스킬 질문 5
  ResumeQnaEntity(
    id: 'resume-10',
    question: '기술적 고민이 협업과 비즈니스에 긍정적인 영향을 미쳤다고 했는데, 구체적으로 어떤 사례가 있나요?',
    questionType: ResumeQuestionType.softSkill,
    evaluationPoint: '기술적 기여를 통해 협업 및 비즈니스 성과에 기여한 경험, 팀과 비즈니스 간의 연계 이해력',
  ),
];

///
/// 이력서 (+포트폴리오) 문답
///

class ResumeQnaEntity extends BaseQnaEntity {
  /// 평가 요소
  final String evaluationPoint;

  /// 하드스킬, 소프스킬 질문 타입
  final ResumeQuestionType questionType;

  ResumeQnaEntity({
    String? id,
    required super.question,
    required this.questionType,
    required this.evaluationPoint,
  }) : super(
          id: id,
          type: QnaType.resume,
        );

  ResumeQnaEntity copyWith({
    String? evaluationPoint,
    ResumeQuestionType? questionType,
    String? id,
    String? question,
  }) {
    return ResumeQnaEntity(
      evaluationPoint: evaluationPoint ?? this.evaluationPoint,
      questionType: questionType ?? this.questionType,
      id: id ?? this.id,
      question: question ?? this.question,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResumeQnaEntity &&
          runtimeType == other.runtimeType &&
          evaluationPoint == other.evaluationPoint &&
          questionType == other.questionType &&
          id == other.id &&
          question == other.question &&
          type == other.type;

  @override
  int get hashCode =>
      evaluationPoint.hashCode ^
      questionType.hashCode ^
      id.hashCode ^
      question.hashCode ^
      type.hashCode;
}
