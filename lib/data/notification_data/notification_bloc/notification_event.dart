import 'package:equatable/equatable.dart';


abstract class NotificationEvent extends Equatable {
  final String? url;
  final int? index;
  final bool? isLoading;
  final Map? body;
  const NotificationEvent({this.index,  this.url,this.body,this.isLoading});

  @override
  List<Object> get props => [];
}


class FetchNotificationType extends NotificationEvent {
  const FetchNotificationType({required super.url});
}
class AllNotificationEvent extends NotificationEvent {
  const AllNotificationEvent({required super.url,required super.isLoading});
}


class FetchInitialNotification extends NotificationEvent {
  const FetchInitialNotification();
}

class DeleteNotificationEvent extends NotificationEvent {
  const DeleteNotificationEvent({required super.body, required super.index});
}





