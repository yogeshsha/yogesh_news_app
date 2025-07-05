part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

class SettingsInitial extends SettingsState {}

class SettingsLoading extends SettingsState {}

class LogOutLoaded extends SettingsState {
  final String details;

  const LogOutLoaded({required this.details});

  @override
  List<Object> get props => [details];
}

class OtherStatusCodeSettingsLoaded extends SettingsState {
  final ApiModel details;

  const OtherStatusCodeSettingsLoaded({required this.details});

  @override
  List<Object> get props => [details];
}

class SettingsError extends SettingsState {
  final String message;

  const SettingsError({required this.message});

  @override
  List<Object> get props => [message];
}
