import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/constants/assets.dart';
import 'package:techtalk/features/tech_set/repositories/entities/skill_set_entity.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';
import 'dart:convert';

class SkillListPage extends BasePage {
  const SkillListPage({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    final targetList = useMemoized(() async {
      final jsonString = await rootBundle.loadString(Assets.jsonStack);

      // json.decode 결과를 적절히 캐스팅
      final List<dynamic> parsedJson = json.decode(jsonString);
      final jsonData = parsedJson
          .whereType<Map<String, dynamic>>() // Map<String, dynamic>만 필터링
          .toList();
      return jsonData.map(SkillSetEntity.fromJson).toList();
    });

    return FutureBuilder(
      future: targetList,
      builder: (context, list) {
        if (list.hasData) {
          return ListView.separated(
            separatorBuilder: (_, __) => Divider(),
            itemCount: list.data?.length ?? 0,
            itemBuilder: (context, index) {
              final item = list.data?[index];
              if (item == null) return const CircularProgressIndicator();
              return Row(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(200),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200),
                      ),
                      child: Image.asset(
                        'assets/skills/${item.imagePath}',
                        fit: BoxFit.fitWidth,
                        width: 100,
                        errorBuilder: (_, __, ___) {
                          print('아지랑이요 : ${item.imagePath}');
                          return Text(
                            item.imagePath,
                            style: TextStyle(color: Colors.red),
                          );
                        },
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text('   ${item.name}   '),
                      Text(
                        item.imagePath,
                        style: TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
