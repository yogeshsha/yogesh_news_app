part of 'session_bloc.dart';


abstract class SessionEvent extends Equatable {
  final Map? body;
  final int? id;
  final String? url;
  final bool? isLoading;

  const SessionEvent({this.body,this.url,this.isLoading,this.id});

  @override
  List<Object> get props => [];
}

class FetchInitialSession extends SessionEvent {
  const FetchInitialSession();
}

class GetSessionEvent extends SessionEvent {
  const GetSessionEvent();
}
