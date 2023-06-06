import 'package:tasky/models/entities/task/task_entity.dart';

class TaskDateUtils {
  static List<TaskEntity> filterItemsByDate({
    required List<TaskEntity> items,
    required DateTime date,
  }) {
    List<TaskEntity> filteredItems = items.where((item) {
      DateTime itemDate = item.dateFromString ?? DateTime.now();
      return itemDate.year == date.year &&
          itemDate.month == date.month &&
          itemDate.day == date.day;
    }).toList();

    return filteredItems;
  }
}
