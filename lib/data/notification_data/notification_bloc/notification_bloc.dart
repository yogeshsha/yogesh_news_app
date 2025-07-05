
import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/common_model/api_model.dart';
import '../domain/notification_model/all_notification_model.dart';
import '../domain/notification_model/notification_type_model.dart';
import '../domain/useCases/notification_usecase_interface.dart';
import 'notification_event.dart';
import 'notification_state.dart';


class  NotificationBloc extends Bloc< NotificationEvent,NotificationState> {
  final NotificationUseCase notificationUseCase;

  NotificationBloc({required this.notificationUseCase}) : super(NotificationInitial()) {

    on<FetchNotificationType>((event, emit) async {
      emit(NotificationLoading());
      try {
        Either<List<NotificationType>,ApiModel> details = await notificationUseCase.notificationTypeApi(event.url ?? "");
        if(details.isLeft){
          emit(NotificationTypeLoaded(details: details.left));
        }else{
          emit(OtherStatusCodeNotificationLoaded(details: details.right));
        }

      } catch (e) {
        emit(NotificationError(message: e.toString()));
      }
    });
    on<AllNotificationEvent>((event, emit) async {
      if(event.isLoading ?? true){
        emit(NotificationLoading());
      }
      try {
        Either<List<AllNotificationModel>,ApiModel> details = await notificationUseCase.allNotificationApi(event.url ?? "");
        if(details.isLeft){
          emit(AllNotificationLoaded(notifications: details.left));
        }else{
          emit(OtherStatusCodeNotificationLoaded(details: details.right));
        }

      } catch (e) {
        emit(NotificationError(message: e.toString()));
      }
    });
    on<DeleteNotificationEvent>((event, emit) async {
        emit(NotificationLoading());
      try {
        Either<String,ApiModel> details = await notificationUseCase.deleteNotificationApi(event.body ?? {});
        if(details.isLeft){
          emit(DeleteNotificationLoaded(message: details.left,index: event.index));
        }else{
          emit(OtherStatusCodeNotificationLoaded(details: details.right));
        }

      } catch (e) {
        emit(NotificationError(message: e.toString()));
      }
    });




    on<FetchInitialNotification>((event, emit) async {
      emit(NotificationInitial());
    });
  }
}