part of 'authentication_cubit.dart';

class AuthenticationState extends Equatable {
  final LoadStatus loadDataStatus;
  final int currentPage;

  const AuthenticationState({
    this.loadDataStatus = LoadStatus.initial,
    this.currentPage = 0,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
      ];

  AuthenticationState copyWith({
    LoadStatus? loadDataStatus,
    int? currentPage,
    AutovalidateMode? autoValidateMode,
  }) {
    return AuthenticationState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}
