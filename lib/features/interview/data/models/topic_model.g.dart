// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topic_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TopicModelImpl _$$TopicModelImplFromJson(Map<String, dynamic> json) =>
    _$TopicModelImpl(
      categoryId: json['categoryId'] as String,
      imageUrl: json['imageUrl'] as String,
      id: json['id'] as String,
      name: json['name'] as String,
      lastUpdateDate:
          const TimeStampConverter().fromJson(json['lastUpdateDate']),
    );

Map<String, dynamic> _$$TopicModelImplToJson(_$TopicModelImpl instance) =>
    <String, dynamic>{
      'categoryId': instance.categoryId,
      'imageUrl': instance.imageUrl,
      'id': instance.id,
      'name': instance.name,
      'lastUpdateDate':
          const TimeStampConverter().toJson(instance.lastUpdateDate),
    };
