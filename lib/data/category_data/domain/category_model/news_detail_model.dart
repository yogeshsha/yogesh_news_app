//
//
// class NewsDetailModel {
//   int? id;
//   String? title;
//   String? shortDescription;
//   String? posterImage;
//   int? isLiked;
//   List<Description>? description;
//   String? hindiTitle;
//   String? hindiShortDescription;
//   List<HindiDescription>? hindiDescription;
//   String? updatedAt;
//   int? views;
//   NewsCategory? newsCategory;
//   NewsType? newsType;
//
//   NewsDetailModel(
//       {this.id,
//         this.title,
//         this.shortDescription,
//         this.description,
//         this.hindiTitle,
//         this.hindiShortDescription,
//         this.hindiDescription,
//         this.posterImage,
//         this.updatedAt,
//         this.isLiked,
//         this.views,
//         this.newsCategory,
//         this.newsType});
//
//   NewsDetailModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     title = json['title'];
//     shortDescription = json['shortDescription'];
//     if (json['description'] != null) {
//       description = <Description>[];
//       json['description'].forEach((v) {
//         description!.add(Description.fromJson(v));
//       });
//     }
//     hindiTitle = json['hindiTitle'];
//     hindiShortDescription = json['hindiShortDescription'];
//     if (json['hindiDescription'] != null) {
//       hindiDescription = <HindiDescription>[];
//       json['hindiDescription'].forEach((v) {
//         hindiDescription!.add(HindiDescription.fromJson(v));
//       });
//     }
//     posterImage = json['posterImage'];
//     updatedAt = json['updatedAt'];
//     isLiked = json['isLiked'];
//     views = json['views'];
//     newsCategory = json['NewsCategory'] != null
//         ? NewsCategory.fromJson(json['NewsCategory'])
//         : null;
//     newsType = json['NewsType'] != null
//         ? NewsType.fromJson(json['NewsType'])
//         : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['title'] = title;
//     data['shortDescription'] = shortDescription;
//     if (description != null) {
//       data['description'] = description!.map((v) => v.toJson()).toList();
//     }
//     data['hindiTitle'] = hindiTitle;
//     data['hindiShortDescription'] = hindiShortDescription;
//     if (hindiDescription != null) {
//       data['hindiDescription'] =
//           hindiDescription!.map((v) => v.toJson()).toList();
//     }
//     data['posterImage'] = posterImage;
//     data['updatedAt'] = updatedAt;
//     data['isLiked'] = isLiked;
//     data['views'] = views;
//     if (newsCategory != null) {
//       data['NewsCategory'] = newsCategory!.toJson();
//     }
//     if (newsType != null) {
//       data['NewsType'] = newsType!.toJson();
//     }
//     return data;
//   }
// }
//
// class Description {
//   String? detailDescription;
//
//   Description({this.detailDescription});
//
//   Description.fromJson(Map<String, dynamic> json) {
//     detailDescription = json['asdg'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['asdg'] = detailDescription;
//     return data;
//   }
// }
// class HindiDescription {
//   String? detailDescription;
//
//   HindiDescription({this.detailDescription});
//
//   HindiDescription.fromJson(Map<String, dynamic> json) {
//     detailDescription = json['asdg'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['asdg'] = detailDescription;
//     return data;
//   }
// }
//
// class NewsCategory {
//   int? id;
//   String? image;
//   String? name;
//   String? hindiName;
//
//   NewsCategory({this.id, this.image, this.name, this.hindiName});
//
//   NewsCategory.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     image = json['image'];
//     name = json['name'];
//     hindiName = json['hindiName'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['image'] = image;
//     data['name'] = name;
//     data['hindiName'] = hindiName;
//     return data;
//   }
// }
//
// class NewsType {
//   int? id;
//   String? name;
//   String? slug;
//
//   NewsType({this.id, this.name, this.slug});
//
//   NewsType.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     slug = json['slug'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['name'] = name;
//     data['slug'] = slug;
//     return data;
//   }
// }
