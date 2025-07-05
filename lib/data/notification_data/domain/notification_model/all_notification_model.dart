class AllNotificationModel {
  int? id;
  int? userId;
  int? notificationCategoryId;
  String? type;
  List<ActionsModel>? actions;
  Data? data;
  bool? status;
  bool? isActive;
  String? createdAt;
  String? updatedAt;

  AllNotificationModel(
      {this.id,
        this.userId,
        this.notificationCategoryId,
        this.type,
        this.actions,
        this.data,
        this.status,
        this.isActive,
        this.createdAt,
        this.updatedAt});

  AllNotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    notificationCategoryId = json['notificationCategoryId'];
    type = json['type'];
    if (json['actions'] != null) {
      actions = <ActionsModel>[];
      json['actions'].forEach((v) {
        actions!.add(ActionsModel.fromJson(v));
      });
    }
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    status = json['status'];
    isActive = json['isActive'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['notificationCategoryId'] = notificationCategoryId;
    data['type'] = type;
    if (actions != null) {
      data['actions'] = actions!.map((v) => v.toJson()).toList();
    }
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status'] = status;
    data['isActive'] = isActive;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class ActionsModel {
  String? type;
  String? title;
  String? callbackUrl;

  ActionsModel({this.type, this.title, this.callbackUrl});

  ActionsModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    title = json['title'];
    callbackUrl = json['callbackUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['title'] = title;
    data['callbackUrl'] = callbackUrl;
    return data;
  }
}

class Data {
  String? title;
  List<String>? images;
  String? imageUrl;
  String? subTitle;
  String? description;

  Data(
      {this.title,
        this.images,
        this.imageUrl,
        this.subTitle,
        this.description});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    images = (json['images'] ?? []).cast<String>();
    imageUrl = json['imageUrl'];
    subTitle = json['subTitle'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['images'] = images;
    data['imageUrl'] = imageUrl;
    data['subTitle'] = subTitle;
    data['description'] = description;
    return data;
  }
}
