import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../location_listing/domain/enums/enum_location.dart';
import '../../domain/entities/locale_creation.dart';
import '../../domain/usecases/create_locale.dart';
import '../../domain/usecases/update_locale.dart';

part 'creation_state.dart';

class CreationCubit extends Cubit<CreationState> {
  CreationCubit({required this.createLocale, required this.updateLocale})
      : super(const CreationState());

  final CreateLocale createLocale;
  final UpdateLocale updateLocale;

  void create() async {
    emit(state.copyWith(status: CreationStateStatus.loading));

    await createLocale(state.locale).then((result) {
      result.fold(
        (error) => emit(state.copyWith(
          status: CreationStateStatus.error,
          errorMessage: error.toString(),
        )),
        (_) => emit(state.copyWith(status: CreationStateStatus.success)),
      );
    });
  }

  void update() async {
    emit(state.copyWith(status: CreationStateStatus.loading));

    await updateLocale(state.locale).then((result) {
      result.fold(
        (error) => emit(state.copyWith(
          status: CreationStateStatus.error,
          errorMessage: error.toString(),
        )),
        (_) => emit(state.copyWith(status: CreationStateStatus.updated)),
      );
    });
  }

  void setLocale(LocaleCreation locale) {
    emit(state.copyWith(locale: locale));
  }

  void reset() {
    emit(const CreationState());
  }
}
