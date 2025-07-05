
import 'package:expandable/expandable.dart';

class SubscriptionMainModel {
  int? count;
  List<SubscriptionListModel>? subscriptionList;
  SubscriptionMainModel({this.count, this.subscriptionList});
  SubscriptionMainModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['rows'] != null) {
      subscriptionList = <SubscriptionListModel>[];
      json['rows'].forEach((v) {
        subscriptionList!.add(SubscriptionListModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    if (subscriptionList != null) {
      data['rows'] = subscriptionList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubscriptionListModel {
  int? id;
  String? name;
  double? price;
  double? discountedPrice;
  int? validityInDays;
  String? description;
  // Features? features;
  bool? isActive;
  String? createdAt;
  List<String>? shortDescription;
  ExpandableController controller = ExpandableController();

  SubscriptionListModel(
      {this.id,
        this.name,
        this.price,
        this.discountedPrice,
        this.validityInDays,
        this.description,
        // this.features,
        this.isActive,
        this.createdAt,this.shortDescription});

  SubscriptionListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = (json['price']??0).toDouble();
    discountedPrice = (json['discountedPrice']??0).toDouble();
    validityInDays = json['validityInDays'];
    description = json['description'];
    // features = json['features'] != null
    //     ? Features.fromJson(json['features'])
    //     : null;
    isActive = json['isActive'];
    createdAt = json['createdAt'];
    shortDescription = (json['shortDescription']??[]).cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['discountedPrice'] = discountedPrice;
    data['validityInDays'] = validityInDays;
    data['description'] = description;
    // if (features != null) {
    //   data['features'] = features!.toJson();
    // }
    data['isActive'] = isActive;
    data['createdAt'] = createdAt;
    data['shortDescription'] = shortDescription;

    return data;
  }
}

class Features {


  String? features;

  Features({this.features});

  Features.fromJson(Map<String, dynamic> json) {
    features = json['features'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['features'] = features;
    return data;
  }
}


