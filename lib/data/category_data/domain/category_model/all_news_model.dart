import 'package:newsapp/data/category_data/domain/category_model/your_news_model.dart';
import 'package:newsapp/utils/app.dart';

import 'news_category_model.dart';

class  AllNewsModel {
  int? id;
  String? title;
  String? shortDescription;
  String? posterImage;
  int? isLiked;
  List<Description>? description;
  String? hindiTitle;
  String? hindiShortDescription;
  List<Description>? hindiDescription;
  String? updatedAt;
  int? views;
  NewsCategoryModel? newsCategory;
  NewsType? newsType;
  User? user;
  List<String>? media;


  AllNewsModel(
      {this.title,
        this.shortDescription,
        this.id,
        this.description,
        this.hindiTitle,
        this.media,
        this.posterImage,
        this.isLiked,
        this.hindiShortDescription,
        this.hindiDescription,
        this.updatedAt,
        this.views,
        this.newsCategory,
        this.newsType,
        this.user,
      });

  AllNewsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    posterImage = json['posterImage'];
    try{
      media = (json['media'] ?? []).cast<String>();
    }catch(e){
      AppHelper.myPrint(e.toString());
    }

    isLiked = json['isLiked'];
    shortDescription = json['shortDescription'];
    if (json['description'] != null) {
      description = <Description>[];
      json['description'].forEach((v) {
        description!.add(Description.fromJson(v));
      });
    }
    hindiTitle = json['hindiTitle'];
    hindiShortDescription = json['hindiShortDescription'];
    if (json['hindiDescription'] != null) {
      hindiDescription = <Description>[];
      json['hindiDescription'].forEach((v) {
        hindiDescription!.add(Description.fromJson(v));
      });
    }
    updatedAt = json['updatedAt'];
    views = json['views'];
    newsCategory = json['NewsCategory'] != null
        ? NewsCategoryModel.fromJson(json['NewsCategory'])
        : null;
    newsType = json['NewsType'] != null
        ? NewsType.fromJson(json['NewsType'])
        : null;
    user = json['User'] != null ? User.fromJson(json['User']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['id'] = id;
    data['shortDescription'] = shortDescription;
    if (description != null) {
      data['description'] = description!.map((v) => v.toJson()).toList();
    }
    data['media'] = media;
    data['hindiTitle'] = hindiTitle;
    data['posterImage'] = posterImage;
    data['isLiked'] = isLiked;
    data['hindiShortDescription'] = hindiShortDescription;
    if (hindiDescription != null) {
      data['hindiDescription'] =
          hindiDescription!.map((v) => v.toJson()).toList();
    }
    data['updatedAt'] = updatedAt;
    data['views'] = views;
    if (newsCategory != null) {
      data['NewsCategory'] = newsCategory!.toJson();
    }
    if (newsType != null) {
      data['NewsType'] = newsType!.toJson();
    }
    if (user != null) {
      data['User'] = user!.toJson();
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
class NewsType {
  int? id;
  String? name;
  String? slug;

  NewsType({this.id, this.name, this.slug});

  NewsType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    return data;
  }
}



