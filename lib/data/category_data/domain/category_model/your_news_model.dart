import 'package:newsapp/data/category_data/domain/category_model/all_news_model.dart';

class YourNewsModel {
  int? count;
  List<AllNewsModel>? yourNewsListModel;

  YourNewsModel({this.count, this.yourNewsListModel});

  YourNewsModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['rows'] != null) {
      yourNewsListModel = <AllNewsModel>[];
      json['rows'].forEach((v) {
        yourNewsListModel!.add(AllNewsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    if (yourNewsListModel != null) {
      data['rows'] = yourNewsListModel!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
//
// class YourNewsList {
//   int? id;
//   String? title;
//   String? description;
//   bool? isActive;
//   bool? isPushed;
//   bool? isPublished;
//   String? createdAt;
//   User? user;
//
//   YourNewsList(
//       {this.id,
//         this.title,
//         this.description,
//         this.isActive,
//         this.isPushed,
//         this.isPublished,
//         this.createdAt,
//         this.user});
//
//   YourNewsList.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     title = json['title'];
//     description = json['description'];
//     isActive = json['isActive'];
//     isPushed = json['isPushed'];
//     isPublished = json['isPublished'];
//     createdAt = json['createdAt'];
//     user = json['User'] != null ? User.fromJson(json['User']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['title'] = title;
//     data['description'] = description;
//     data['isActive'] = isActive;
//     data['isPushed'] = isPushed;
//     data['isPublished'] = isPublished;
//     data['createdAt'] = createdAt;
//     if (user != null) {
//       data['User'] = user!.toJson();
//     }
//     return data;
//   }
// }

class User {
  int? id;
  String? name;

  User({this.id, this.name});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
