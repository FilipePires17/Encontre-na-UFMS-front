part of 'creation_cubit.dart';

enum CreationStateStatus { initial, loading, success, error }

class CreationState extends Equatable {
  const CreationState({
    this.status = CreationStateStatus.initial,
    this.errorMessage,
  });

  final CreationStateStatus status;
  final String? errorMessage;

  CreationState copyWith({
    CreationStateStatus? status,
    String? errorMessage,
  }) {
    return CreationState(
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage];
}
