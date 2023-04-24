part of 'main_screen_cubit.dart';

class MainScreenState extends Equatable {
  final LoadStatus loadDataStatus;
  final int currentPage;

  const MainScreenState({
    this.loadDataStatus = LoadStatus.initial,
    this.currentPage = 0,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
        currentPage,
      ];

  MainScreenState copyWith({
    LoadStatus? loadDataStatus,
    int? currentPage,
  }) {
    return MainScreenState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}
