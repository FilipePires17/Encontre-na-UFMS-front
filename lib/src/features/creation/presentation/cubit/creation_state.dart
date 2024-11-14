part of 'creation_cubit.dart';

enum CreationStateStatus { initial, loading, success, error }

class CreationState extends Equatable {
  const CreationState({
    this.status = CreationStateStatus.initial,
    this.locale = const LocaleCreation(
      name: '',
      address: '',
      latitude: 0,
      longitude: 0,
      localizationLink: '',
      // TODO: horrível
      type: EnumLocation.banks,
    ),
    this.errorMessage,
  });

  final CreationStateStatus status;
  final LocaleCreation locale;
  final String? errorMessage;

  CreationState copyWith({
    CreationStateStatus? status,
    LocaleCreation? locale,
    String? errorMessage,
  }) {
    return CreationState(
      status: status ?? this.status,
      locale: locale ?? this.locale,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, locale, errorMessage];
}
