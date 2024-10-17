part of 'profile_edit_bloc.dart';

sealed class ProfileEditState extends Equatable {
  const ProfileEditState();
  
  @override
  List<Object> get props => [];
}

final class ProfileEditInitial extends ProfileEditState {}
