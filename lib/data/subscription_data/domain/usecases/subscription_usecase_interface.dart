import 'package:either_dart/either.dart';
import 'package:newsapp/data/subscription_data/domain/subscription_model/current_subscription_model.dart';
import '../../../../constants/common_model/api_model.dart';
import '../repo/subscription_repo_interface.dart';
import '../subscription_model/subscription_models.dart';

class SubscriptionUseCase {
  final SubscriptionRepository subscriptionRepository;
  SubscriptionUseCase({required this.subscriptionRepository});

  Future<Either<SubscriptionMainModel,ApiModel>> getSubscriptionApi(String url) {
    return subscriptionRepository.getSubscriptionApi(url);
  }

  Future<Either<String,ApiModel>> addSubscriptionApi(Map body) {
    return subscriptionRepository.addSubscriptionApi(body);
  }
  Future<Either<String,ApiModel>> addFreeSubscriptionApi() {
    return subscriptionRepository.addFreeSubscriptionApi();
  }

  Future<Either<String,ApiModel>> renewSubscriptionApi(Map body) {
    return subscriptionRepository.renewSubscriptionApi(body);
  }

  Future<Either<String,ApiModel>> upgradeSubscriptionApi(Map body) {
    return subscriptionRepository.upgradeSubscriptionApi(body);
  }

  Future<Either<MyCurrentSubscriptionModel,ApiModel>> getCurrentSubscriptionApi() {
    return subscriptionRepository.getCurrentSubscriptionApi();
  }
}
