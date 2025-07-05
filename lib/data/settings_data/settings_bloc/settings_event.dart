part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  final Map? body;
  const SettingsEvent({this.body});

  @override
  List<Object?> get props => [];
}

class LogoutEvent extends SettingsEvent {
  const LogoutEvent({required super.body});
}


class FetchInitialSettings extends SettingsEvent {
  const FetchInitialSettings();
}
