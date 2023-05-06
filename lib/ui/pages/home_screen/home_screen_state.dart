part of 'home_screen_cubit.dart';

class MainScreenState extends Equatable {
  final LoadStatus loadDataStatus;

  const MainScreenState({
    this.loadDataStatus = LoadStatus.initial,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
      ];

  MainScreenState copyWith({
    LoadStatus? loadDataStatus,
  }) {
    return MainScreenState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
    );
  }
}
