import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'profile_edit_event.dart';
part 'profile_edit_state.dart';

class ProfileEditBloc extends Bloc<ProfileEditEvent, ProfileEditState> {
  ProfileEditBloc() : super(ProfileEditInitial()) {
    on<ProfileEditEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
