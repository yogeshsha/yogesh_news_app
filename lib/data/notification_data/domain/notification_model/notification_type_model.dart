
import 'package:flutter/material.dart';

class NotificationType {
  int? id;
  int? notificationCount;
  String? key;
  String? name;
  String? hindiName;
  String? iconUrl;
  bool? isSelected;
  ScrollController scrollController = ScrollController();

  NotificationType({this.id, this.key, this.name, this.hindiName, this.notificationCount, this.iconUrl,this.isSelected});

  NotificationType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    hindiName = json['hindiName'];
    notificationCount = json['notificationCount'];
    name = json['name'];
    iconUrl = json['iconUrl'];
    isSelected = json['isSelected'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['notificationCount'] = notificationCount;
    data['key'] = key;
    data['hindiName'] = hindiName;
    data['name'] = name;
    data['iconUrl'] = iconUrl;
    data['isSelected'] = isSelected;
    return data;
  }
}
