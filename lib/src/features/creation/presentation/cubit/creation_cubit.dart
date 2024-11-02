import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/locale_creation.dart';
import '../../domain/usecases/create_locale.dart';

part 'creation_state.dart';

class CreationCubit extends Cubit<CreationState> {
  CreationCubit({required this.createLocale}) : super(const CreationState());

  final CreateLocale createLocale;

  void create(LocaleCreation location) async {
    emit(state.copyWith(status: CreationStateStatus.loading));

    await createLocale(location).then((result) {
      result.fold(
        (error) => emit(state.copyWith(
          status: CreationStateStatus.error,
          errorMessage: error.toString(),
        )),
        (_) => emit(state.copyWith(status: CreationStateStatus.success)),
      );
    });
  }
}
