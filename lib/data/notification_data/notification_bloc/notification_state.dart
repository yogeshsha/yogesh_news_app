import 'package:equatable/equatable.dart';

import '../../../constants/common_model/api_model.dart';
import '../domain/notification_model/all_notification_model.dart';
import '../domain/notification_model/notification_type_model.dart';


abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}


class NotificationTypeLoaded extends NotificationState {
  final List<NotificationType> details;

  const NotificationTypeLoaded({required this.details});

  @override
  List<Object> get props => [details];
}

class AllNotificationLoaded extends NotificationState {
  final List<AllNotificationModel> notifications;

  const AllNotificationLoaded({required this.notifications});

  @override
  List<Object> get props => [notifications];
}

class DeleteNotificationLoaded extends NotificationState {
  final String message;
  final int? index;

  const DeleteNotificationLoaded({required this.message , required this.index});

  @override
  List<Object> get props => [message];
}



class OtherStatusCodeNotificationLoaded extends NotificationState {
  final ApiModel details;

  const OtherStatusCodeNotificationLoaded({required this.details});

  @override
  List<Object> get props => [details];
}

class NotificationError extends NotificationState {
  final String message;

  const NotificationError({required this.message});

  @override
  List<Object> get props => [message];
}


