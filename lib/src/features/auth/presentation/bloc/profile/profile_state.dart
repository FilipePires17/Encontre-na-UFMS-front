part of 'profile_bloc.dart';

enum ProfileStateStatus { initial, loading, loaded, error }

class ProfileState extends Equatable {
  const ProfileState({
    this.status = ProfileStateStatus.initial,
    this.user,
    this.errorMessage,
  });

  final ProfileStateStatus status;
  final User? user;
  final String? errorMessage;

  ProfileState copyWith({
    ProfileStateStatus? status,
    User? user,
    String? errorMessage,
  }) {
    return ProfileState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, user, errorMessage];
}
