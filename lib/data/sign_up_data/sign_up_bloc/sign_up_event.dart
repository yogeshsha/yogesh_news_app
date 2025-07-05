part of 'sign_up_bloc.dart';

// ignore: must_be_immutable
abstract class SignUpEvent extends Equatable {
  Map body;
  SignUpEvent({required this.body});

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class FetchSignUp extends SignUpEvent {
  FetchSignUp({required super.body});
}

// ignore: must_be_immutable
class FetchInitialSignUp extends SignUpEvent {
  FetchInitialSignUp({required super.body});
}
