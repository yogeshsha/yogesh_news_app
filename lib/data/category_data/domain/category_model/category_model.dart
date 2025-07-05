class CategoryModel {
  List<LatestNews>? latestNews;
  List<NewsCategory>? newsCategory;
  List<LatestNews>? featuredNews;

  CategoryModel({this.latestNews, this.newsCategory, this.featuredNews});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    if (json['latestNews'] != null) {
      latestNews = <LatestNews>[];
      json['latestNews'].forEach((v) {
        latestNews!.add(LatestNews.fromJson(v));
      });
    }
    if (json['newsCategory'] != null) {
      newsCategory = <NewsCategory>[];
      json['newsCategory'].forEach((v) {
        newsCategory!.add(NewsCategory.fromJson(v));
      });
    }
    if (json['featuredNews'] != null) {
      featuredNews = <LatestNews>[];
      json['featuredNews'].forEach((v) {
        featuredNews!.add(LatestNews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (latestNews != null) {
      data['latestNews'] = latestNews!.map((v) => v.toJson()).toList();
    }
    if (newsCategory != null) {
      data['newsCategory'] = newsCategory!.map((v) => v.toJson()).toList();
    }
    if (featuredNews != null) {
      data['featuredNews'] = featuredNews!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LatestNews {
  int? id;
  int? categoryId;
  String? title;
  String? shortDescription;
  List<Description>? description;
  String? posterImage;
  String? createdAt;
  String? updatedAt;
  NewsCategory? newsCategory;
  List<String>? isLiked;

  LatestNews(
      {this.id,
        this.categoryId,
        this.title,
        this.shortDescription,
        this.description,
        this.posterImage,
        this.createdAt,
        this.updatedAt,
        this.newsCategory,this.isLiked});

  LatestNews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['categoryId'];

    title = json['title'];
    shortDescription = json['shortDescription'];
    if (json['description'] != null) {
      description = <Description>[];
      json['description'].forEach((v) {
        description!.add(Description.fromJson(v));
      });
    }
    posterImage = json['posterImage'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    isLiked = [];
    newsCategory = json['NewsCategory'] != null
        ? NewsCategory.fromJson(json['NewsCategory'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['categoryId'] = categoryId;
    data['title'] = title;
    data['shortDescription'] = shortDescription;
    if (description != null) {
      data['description'] = description!.map((v) => v.toJson()).toList();
    }
    data['posterImage'] = posterImage;
    data['createdAt'] = createdAt;
    data['isLiked'] = isLiked;
    data['updatedAt'] = updatedAt;
    if (newsCategory != null) {
      data['NewsCategory'] = newsCategory!.toJson();
    }
    return data;
  }
}

class Description {
  String? val;
  String? type;

  Description({this.val, this.type});

  Description.fromJson(Map<String, dynamic> json) {
    val = json['val'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['val'] = val;
    data['type'] = type;
    return data;
  }
}

class NewsCategory {
  int? id;
  int? templateId;
  String? name;

  NewsCategory(
      {this.id,
        this.templateId,
        this.name,});

  NewsCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    templateId = json['templateId'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['templateId'] = templateId;
    data['name'] = name;
    return data;
  }
}
