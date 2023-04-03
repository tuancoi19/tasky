part of 'signin_cubit.dart';

class SigninState extends Equatable {
  final LoadStatus loadDataStatus;

  const SigninState({
    this.loadDataStatus = LoadStatus.initial,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
      ];

  SigninState copyWith({
    LoadStatus? loadDataStatus,
  }) {
    return SigninState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
    );
  }
}
