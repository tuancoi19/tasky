import 'package:tasky/models/entities/category/category_entity.dart';
import 'package:tasky/models/entities/task/task_entity.dart';

class GlobalData {
  GlobalData._privateConstructor();

  static final GlobalData instance = GlobalData._privateConstructor();

  String? userID;

  List<TaskEntity> tasksList = [];

  List<CategoryEntity> categoriesList = [];
}
