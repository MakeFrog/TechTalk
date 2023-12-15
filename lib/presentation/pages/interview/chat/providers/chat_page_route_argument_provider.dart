import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/chat/repositories/entities/chat_qna_progress_info_entity.dart';
import 'package:techtalk/features/shared/enums/interviewer_avatar.dart';
import 'package:techtalk/features/topic/topic.dart';

part 'chat_page_route_argument_provider.g.dart';

@riverpod
ChatPageRouteArg chatPageRouteArg(ChatPageRouteArgRef ref) {
  throw Exception('Chat Page : argument missed');
}
