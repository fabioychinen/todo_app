import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'todo_collection_model.g.dart';

@JsonSerializable()
class ToDoCollectionModel extends Equatable {
  const ToDoCollectionModel({
    required this.colorIndex,
    required this.id,
    required this.title,
  });

  factory ToDoCollectionModel.fromJson(Map<String, dynamic> json) =>
      _$ToDoCollectionModelFromJson(json);

  Map<String, dynamic> toJson() => _$ToDoCollectionModelToJson(this);

  final int colorIndex;
  final String title;
  final String id;

  @override
  List<Object?> get props => [
        id,
        title,
        colorIndex,
      ];
}
