// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_collection_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ToDoCollectionModel _$ToDoCollectionModelFromJson(Map<String, dynamic> json) =>
    ToDoCollectionModel(
      colorIndex: json['colorIndex'] as int,
      id: json['id'] as String,
      title: json['title'] as String,
    );

Map<String, dynamic> _$ToDoCollectionModelToJson(
        ToDoCollectionModel instance) =>
    <String, dynamic>{
      'colorIndex': instance.colorIndex,
      'title': instance.title,
      'id': instance.id,
    };
