import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tasky/configs/app_configs.dart';
import 'package:tasky/global/global_data.dart';
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
  String? categoryId;

  @JsonKey()
  List<String>? documents;

  TaskEntity({
    this.title,
    this.note,
    this.categoryId,
    this.documents,
    this.date,
    this.start,
    this.end,
  });

  factory TaskEntity.fromJson(Map<String, dynamic> json) =>
      _$TaskEntityFromJson(json);

  Map<String, dynamic> toJson() => _$TaskEntityToJson(this);

  @override
  bool operator ==(Object other) =>
      other is TaskEntity &&
      runtimeType == other.runtimeType &&
      id == other.id &&
      title == other.title &&
      note == other.note &&
      date == other.date &&
      start == other.start &&
      end == other.end &&
      categoryId == other.categoryId &&
      listEquals(documents, other.documents);

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

  CategoryEntity? get category {
    return GlobalData.instance.categoriesList
        .singleWhere((element) => element.id == categoryId);
  }
}
