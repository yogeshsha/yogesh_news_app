class FavoriteModel {
  int? id;
  int? newsId;
  int? userId;
  bool? status;
  String? createdAt;
  String? updatedAt;
  News? news;

  FavoriteModel(
      {this.id,
        this.newsId,
        this.userId,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.news});

  FavoriteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    newsId = json['newsId'];
    userId = json['userId'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    news = json['News'] != null ? News.fromJson(json['News']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['newsId'] = newsId;
    data['userId'] = userId;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (news != null) {
      data['News'] = news!.toJson();
    }
    return data;
  }
}

class News {
  int? id;
  int? categoryId;
  int? typeId;
  int? createdBy;
  String? title;
  String? shortDescription;
  String? posterImage;
  bool? isActive;
  bool? status;
  String? createdAt;
  String? updatedAt;
  NewsCategory? newsCategory;

  News(
      {this.id,
        this.categoryId,
        this.typeId,
        this.createdBy,
        this.title,
        this.shortDescription,
        this.posterImage,
        this.isActive,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.newsCategory});

  News.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['categoryId'];
    typeId = json['typeId'];
    createdBy = json['createdBy'];
    title = json['title'];
    shortDescription = json['shortDescription'];
    posterImage = json['posterImage'];
    isActive = json['isActive'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    newsCategory = json['NewsCategory'] != null
        ? NewsCategory.fromJson(json['NewsCategory'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['categoryId'] = categoryId;
    data['typeId'] = typeId;
    data['createdBy'] = createdBy;
    data['title'] = title;
    data['shortDescription'] = shortDescription;
    data['posterImage'] = posterImage;
    data['isActive'] = isActive;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (newsCategory != null) {
      data['NewsCategory'] = newsCategory!.toJson();
    }
    return data;
  }
}

class NewsCategory {
  int? id;
  int? templateId;
  String? image;
  String? name;
  bool? isActive;
  bool? status;
  String? createdAt;
  String? updatedAt;

  NewsCategory(
      {this.id,
        this.templateId,
        this.image,
        this.name,
        this.isActive,
        this.status,
        this.createdAt,
        this.updatedAt});

  NewsCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    templateId = json['templateId'];
    image = json['image'];
    name = json['name'];
    isActive = json['isActive'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['templateId'] = templateId;
    data['image'] = image;
    data['name'] = name;
    data['isActive'] = isActive;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
