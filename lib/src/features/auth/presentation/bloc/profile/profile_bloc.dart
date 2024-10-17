import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/user.dart';
import '../../../domain/usecases/edit_profile.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final EditProfile editProfile;

  ProfileBloc({required this.editProfile}) : super(const ProfileState()) {
    on<EditProfileEvent>((event, emit) async {
      emit(state.copyWith(status: ProfileStateStatus.loading));

      await editProfile(name: event.name, password: event.password).then(
        (res) => res.match(
          (e) {
            emit(state.copyWith(
              status: ProfileStateStatus.error,
              errorMessage: 'Erro ao editar informações do usuário',
            ));
          },
          (user) {
            emit(state.copyWith(
              status: ProfileStateStatus.loaded,
              user: user,
            ));
          },
        ),
      );
    });
  }
}
