part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();
}

final class EditProfileEvent extends ProfileEvent {
  final String? name;
  final String? password;

  const EditProfileEvent({this.name, this.password});

  @override
  List<Object?> get props => [name, password];
}
