import 'package:json_annotation/json_annotation.dart';
import 'package:tasky/models/entities/category/category_entity.dart';

part 'task_entity.g.dart';

@JsonSerializable()
class TaskEntity {
  @JsonKey()
  String title;

  @JsonKey()
  String note;

  @JsonKey()
  String date;

  @JsonKey()
  String start;

  @JsonKey()
  String end;

  // @JsonKey()
  // CategoryEntity category;

  @JsonKey()
  List<String?> documents;

  TaskEntity({
    required this.title,
    required this.note,
    // required this.category,
    required this.documents,
    required this.date,
    required this.start,
    required this.end,
  });

  factory TaskEntity.fromJson(Map<String, dynamic> json) =>
      _$TaskEntityFromJson(json);

  Map<String, dynamic> toJson() => _$TaskEntityToJson(this);
}
