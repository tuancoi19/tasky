import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tasky/global/global_data.dart';
import 'package:tasky/models/entities/task/task_entity.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(const SearchState());

  void searchByName({required String keyword}) {
    final data = [...GlobalData.instance.tasksList];
    List<TaskEntity> result = [];
    if (keyword.isNotEmpty) {
      result.addAll(
        data
            .where(
              (element) =>
                  element.title
                      ?.toLowerCase()
                      .contains(keyword.toLowerCase()) ??
                  false,
            )
            .toList(),
      );
    }
    emit(state.copyWith(taskList: result));
  }
}
