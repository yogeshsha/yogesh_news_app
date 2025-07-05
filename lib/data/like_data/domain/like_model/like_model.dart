class LikeModel {
  bool? status;
  int? id;
  int? newsId;
  int? userId;
  String? updatedAt;
  String? createdAt;

  LikeModel(
      {this.status,
        this.id,
        this.newsId,
        this.userId,
        this.updatedAt,
        this.createdAt});

  LikeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    id = json['id'];
    newsId = json['newsId'];
    userId = json['userId'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['id'] = id;
    data['newsId'] = newsId;
    data['userId'] = userId;
    data['updatedAt'] = updatedAt;
    data['createdAt'] = createdAt;
    return data;
  }
}
