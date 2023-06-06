import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tasky/configs/app_configs.dart';
import 'package:tasky/models/entities/category/category_entity.dart';

part 'task_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class TaskEntity {
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? id;

  @JsonKey()
  String? title;

  @JsonKey()
  String? note;

  @JsonKey()
  String? date;

  @JsonKey()
  String? start;

  @JsonKey()
  String? end;

  @JsonKey()
  CategoryEntity? category;

  @JsonKey()
  List<String>? documents;

  TaskEntity({
    this.title,
    this.note,
    this.category,
    this.documents,
    this.date,
    this.start,
    this.end,
  });

  factory TaskEntity.fromJson(Map<String, dynamic> json) =>
      _$TaskEntityFromJson(json);

  Map<String, dynamic> toJson() => _$TaskEntityToJson(this);

  DateTime? get dateFromString {
    if (date != null && date!.isNotEmpty) {
      DateFormat dateFormat = DateFormat(AppConfigs.dateDisplayFormat);
      DateTime dateTime = dateFormat.parse(date!);
      return dateTime;
    }
    return null;
  }

  TimeOfDay? get startFromString {
    if (start != null && start!.isNotEmpty) {
      List<String> parts = start!.split(':');
      int hours = int.parse(parts[0]);
      int minutes = int.parse(parts[1]);

      return TimeOfDay(hour: hours, minute: minutes);
    }
    return null;
  }

  TimeOfDay? get endFromString {
    if (start != null && end!.isNotEmpty) {
      List<String> parts = end!.split(':');
      int hours = int.parse(parts[0]);
      int minutes = int.parse(parts[1]);

      return TimeOfDay(hour: hours, minute: minutes);
    }
    return null;
  }
}
