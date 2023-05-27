import 'package:json_annotation/json_annotation.dart';

part 'category_entity.g.dart';

@JsonSerializable()
class CategoryEntity {
  @JsonKey()
  String title;

  @JsonKey()
  String color;

  CategoryEntity({required this.title, required this.color});

  factory CategoryEntity.fromJson(Map<String, dynamic> json) =>
      _$CategoryEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryEntityToJson(this);

  int get colorHex {
    return int.parse(color, radix: 16);
  }
}