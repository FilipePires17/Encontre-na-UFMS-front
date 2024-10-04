part of 'section_bloc.dart';

enum SectionStateStatus { initial, loading, loaded, error }

class SectionState extends Equatable {
  const SectionState({
    this.status = SectionStateStatus.initial,
    this.section = const Section(),
    this.error,
  });

  final SectionStateStatus status;
  final Section section;
  final String? error;

  @override
  List<Object?> get props => [status, section, error];
}
