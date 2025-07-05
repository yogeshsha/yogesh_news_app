import 'package:either_dart/either.dart';
import 'package:newsapp/data/subscription_data/domain/subscription_model/current_subscription_model.dart';
import '../../../../constants/common_model/api_model.dart';
import '../subscription_model/subscription_models.dart';

abstract class SubscriptionRepository {

  Future<Either<SubscriptionMainModel,ApiModel>> getSubscriptionApi(String url);
  Future<Either<String,ApiModel>> addSubscriptionApi(Map body);
  Future<Either<String,ApiModel>> addFreeSubscriptionApi();
  Future<Either<String,ApiModel>> renewSubscriptionApi(Map body);
  Future<Either<String,ApiModel>> upgradeSubscriptionApi(Map body);
  Future<Either<MyCurrentSubscriptionModel,ApiModel>> getCurrentSubscriptionApi();
}
