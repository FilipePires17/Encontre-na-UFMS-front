import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/sections.dart';
import '../../../domain/enums/enum_sections.dart';
import '../../../domain/usecases/get_section.dart';

part 'section_event.dart';
part 'section_state.dart';

class SectionBloc extends Bloc<SectionEvent, SectionState> {
  final GetSection getSection;

  SectionBloc({required this.getSection}) : super(const SectionState()) {
    on<GetSectionEvent>((event, emit) async {
      emit(const SectionState(status: SectionStateStatus.loading));

      await getSection(id: event.id, section: event.section).then(
        (result) => result.fold(
          (error) {
            emit(SectionState(
              status: SectionStateStatus.error,
              error: error,
            ));
          },
          (section) {
            emit(SectionState(
              status: SectionStateStatus.loaded,
              section: section,
            ));
          },
        ),
      );
    });
  }
}
