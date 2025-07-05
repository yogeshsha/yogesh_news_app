import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/data/subscription_data/domain/subscription_model/current_subscription_model.dart';
import '../../../constants/common_model/api_model.dart';
import '../domain/subscription_model/subscription_models.dart';
import '../domain/usecases/subscription_usecase_interface.dart';

part 'subscription_event.dart';

part 'subscription_state.dart';

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  final SubscriptionUseCase subscriptionUseCase;

  SubscriptionBloc({required this.subscriptionUseCase})
      : super(SubscriptionInitial()) {
    on<GetAllSubscriptionEvent>((event, emit) async {
      if (event.isLoading ?? true) {
        emit(SubscriptionLoading());
      }
      try {
        Either<SubscriptionMainModel, ApiModel> details =
            await subscriptionUseCase.getSubscriptionApi(event.url ?? "");
        if (details.isLeft) {
          emit(SubscriptionLoaded(details: details.left));
        } else {
          emit(OtherSubscriptionLoaded(details: details.right));
        }
      } catch (e) {
        emit(SubscriptionError(message: e.toString()));
      }
    });

    on<FetchAddSubscription>((event, emit) async {
      if (event.isLoading ?? true) {
        emit(SubscriptionLoading());
      }
      try {
        Either<String, ApiModel> details =
            await subscriptionUseCase.addSubscriptionApi(event.body ?? {});
        if (details.isLeft) {
          emit(AddSubscriptionLoaded(message: details.left));
        } else {
          emit(OtherSubscriptionLoaded(details: details.right));
        }
      } catch (e) {
        emit(SubscriptionError(message: e.toString()));
      }
    });

    on<AddFreeSubscriptionEvent>((event, emit) async {
      emit(SubscriptionLoading());
      try {
        Either<String, ApiModel> details =
            await subscriptionUseCase.addFreeSubscriptionApi();
        if (details.isLeft) {
          emit(AddFreeSubscriptionLoaded(message: details.left));
        } else {
          emit(OtherSubscriptionLoaded(details: details.right));
        }
      } catch (e) {
        emit(SubscriptionError(message: e.toString()));
      }
    });

    on<RenewSubscription>((event, emit) async {
      if (event.isLoading ?? true) {
        emit(SubscriptionLoading());
      }
      try {
        Either<String, ApiModel> details =
            await subscriptionUseCase.renewSubscriptionApi(event.body ?? {});
        if (details.isLeft) {
          emit(RenewSubscriptionLoaded(message: details.left));
        } else {
          emit(OtherSubscriptionLoaded(details: details.right));
        }
      } catch (e) {
        emit(SubscriptionError(message: e.toString()));
      }
    });
    on<UpgradeSubscription>((event, emit) async {
        emit(SubscriptionLoading());
      try {
        Either<String, ApiModel> details =
            await subscriptionUseCase.upgradeSubscriptionApi(event.body ?? {});
        if (details.isLeft) {
          emit(UpgradeSubscriptionLoaded(message: details.left));
        } else {
          emit(OtherSubscriptionLoaded(details: details.right));
        }
      } catch (e) {
        emit(SubscriptionError(message: e.toString()));
      }
    });

    on<GetCurrentSubscription>((event, emit) async {
      emit(SubscriptionLoading());

      try {
        Either<MyCurrentSubscriptionModel, ApiModel> details =
            await subscriptionUseCase.getCurrentSubscriptionApi();
        if (details.isLeft) {
          emit(CurrentSubscriptionLoaded(details: details.left));
        } else {
          emit(OtherSubscriptionLoaded(details: details.right));
        }
      } catch (e) {
        emit(SubscriptionError(message: e.toString()));
      }
    });

    on<FetchInitialSubscription>((event, emit) async {
      emit(SubscriptionInitial());
    });
  }
}
