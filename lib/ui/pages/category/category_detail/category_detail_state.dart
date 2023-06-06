part of 'category_detail_cubit.dart';

class CategoryDetailState extends Equatable {
  final LoadStatus loadDataStatus;

  const CategoryDetailState({
    this.loadDataStatus = LoadStatus.initial,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
      ];

  CategoryDetailState copyWith({
    LoadStatus? loadDataStatus,
  }) {
    return CategoryDetailState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
    );
  }
}
