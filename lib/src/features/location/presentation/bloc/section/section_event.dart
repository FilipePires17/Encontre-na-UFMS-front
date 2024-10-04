part of 'section_bloc.dart';

sealed class SectionEvent extends Equatable {
  const SectionEvent();

  @override
  List<Object> get props => [];
}

class GetSectionEvent extends SectionEvent {
  final int id;
  final EnumSections section;

  const GetSectionEvent({required this.id, required this.section});

  @override
  List<Object> get props => [id, section];
}
