part of 'login_bloc.dart';


abstract class LoginEvent extends Equatable {
  final Map? body;
  const LoginEvent({this.body});

  @override
  List<Object> get props => [];
}


class FetchLogin extends LoginEvent {
  const FetchLogin({required super.body});
}



class FetchInitialLogin extends LoginEvent {
  const FetchInitialLogin();
}
