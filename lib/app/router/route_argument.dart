part of 'router.dart';

typedef ChatPageRouteArg = ({
  InterviewProgressState progressState,
  ({ChatQnaProgressInfoEntity qnaProgressInfo, TopicEntity topic}) qnaAndTopic,
  String roomId,
  InterviewerAvatar interviewer,
});
