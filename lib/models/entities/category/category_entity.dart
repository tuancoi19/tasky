import 'package:json_annotation/json_annotation.dart';

part 'category_entity.g.dart';

@JsonSerializable()
class CategoryEntity {

  @JsonKey(includeFromJson: false, includeToJson: false)
  String? id;

  @JsonKey()
  String? title;

  @JsonKey()
  int? color;

  CategoryEntity({ this.title,  this.color});

  factory CategoryEntity.fromJson(Map<String, dynamic> json) =>
      _$CategoryEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryEntityToJson(this);

  @override
  bool operator ==(other) {
    return other is CategoryEntity &&
        other.color == color &&
        other.title == title;
  }
}
