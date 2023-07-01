import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tasky/global/global_data.dart';
import 'package:tasky/models/entities/category/category_entity.dart';
import 'package:tasky/models/enums/entity_type.dart';

class FirebaseUtils {
  static void listenToFirestoreChanges({
    required Function() onChanged,
    required EntityType type,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(GlobalData.instance.userID)
        .collection(type.toString())
        .snapshots()
        .listen((snapshot) {
      onChanged.call();
    });
  }

  static void listenToTasksOfCategoryChanges({
    required Function() onChanged,
    required String categoryID,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(GlobalData.instance.userID)
        .collection('tasks')
        .where('categoryId', isEqualTo: categoryID)
        .snapshots()
        .listen((snapshot) {
            onChanged();
    });
  }

  static void listenToDetailCategoryChanges({
    required Function(CategoryEntity) onChanged,
    required String categoryID,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(GlobalData.instance.userID)
        .collection('categories')
        .doc(categoryID)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.data() != null) {
        CategoryEntity result = CategoryEntity.fromJson(snapshot.data()!);
        result.id = categoryID;
        GlobalData.instance.categoriesList = GlobalData.instance.categoriesList
            .map((element) => element.id == result.id ? result : element)
            .toList();
        onChanged(result);
      }
    });
  }
}
