import 'package:newsapp/data/subscription_data/domain/subscription_model/subscription_models.dart';

class MyCurrentSubscriptionModel {
  CurrentSubscription? currentSubscription;
  List<SubscriptionListModel>? upgradeTo;

  MyCurrentSubscriptionModel({this.currentSubscription, this.upgradeTo});

  MyCurrentSubscriptionModel.fromJson(Map<String, dynamic> json) {
    currentSubscription = json['currentSubscription'] != null
        ? CurrentSubscription.fromJson(json['currentSubscription'])
        : null;
    if (json['upgradeTo'] != null) {
      upgradeTo = <SubscriptionListModel>[];
      json['upgradeTo'].forEach((v) {
        upgradeTo!.add(SubscriptionListModel.fromJson(v));
      });
    }
    if (json['buySubscription'] != null) {
      upgradeTo = <SubscriptionListModel>[];
      json['buySubscription'].forEach((v) {
        upgradeTo!.add(SubscriptionListModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (currentSubscription != null) {
      data['currentSubscription'] = currentSubscription!.toJson();
    }
    if (upgradeTo != null) {
      data['upgradeTo'] = upgradeTo!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CurrentSubscription {
  int? id;
  int? subscriptionPlanId;
  String? startDate;
  String? endDate;
  String? planStatus;
  String? paymentStatus;
  SubscriptionPlan? subscriptionPlan;

  CurrentSubscription(
      {this.id,
        this.subscriptionPlanId,
        this.startDate,
        this.endDate,
        this.planStatus,
        this.paymentStatus,
        this.subscriptionPlan});

  CurrentSubscription.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subscriptionPlanId = json['subscriptionPlanId'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    planStatus = json['planStatus'];
    paymentStatus = json['paymentStatus'];
    subscriptionPlan = json['SubscriptionPlan'] != null
        ? SubscriptionPlan.fromJson(json['SubscriptionPlan'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['subscriptionPlanId'] = subscriptionPlanId;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['planStatus'] = planStatus;
    data['paymentStatus'] = paymentStatus;
    if (subscriptionPlan != null) {
      data['SubscriptionPlan'] = subscriptionPlan!.toJson();
    }
    return data;
  }
}

class SubscriptionPlan {
  int? id;
  String? name;
  int? price;
  int? discountedPrice;
  String? description;

  SubscriptionPlan(
      {this.id, this.name, this.price, this.discountedPrice, this.description});

  SubscriptionPlan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    discountedPrice = json['discountedPrice'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['discountedPrice'] = discountedPrice;
    data['description'] = description;
    return data;
  }
}


