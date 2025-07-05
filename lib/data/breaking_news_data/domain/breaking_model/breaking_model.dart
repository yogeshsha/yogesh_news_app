
class BreakingNewsModel {
  String? title;
  String? shortDescription;
  String? createdAt;


  // int? id;
  // int? categoryId;
  // int? typeId;
  // int? createdBy;
  // List<Description>? description;
  // Null? posterImage;
  // bool? isApproved;
  // bool? isPublished;
  // bool? isActive;
  // bool? status;
  // String? updatedAt;
  // Null? user;
  // NewsCategory? newsCategory;

  BreakingNewsModel(
      {
        // this.id,
        // this.categoryId,
        // this.typeId,
        // this.createdBy,
        this.title,
        this.shortDescription,
        // this.description,
        // this.posterImage,
        // this.isApproved,
        // this.isPublished,
        // this.isActive,
        // this.status,
        this.createdAt,
        // this.updatedAt,
        // this.user,
        // this.newsCategory
      });

  BreakingNewsModel.fromJson(Map<String, dynamic> json) {
    // id = json['id'];
    // categoryId = json['categoryId'];
    // typeId = json['typeId'];
    // createdBy = json['createdBy'];
    title = json['title'];
    shortDescription = json['shortDescription'];
    // if (json['description'] != null) {
    //   description = <Description>[];
    //   json['description'].forEach((v) {
    //     description!.add(Description.fromJson(v));
    //   });
    // }
    // posterImage = json['posterImage'];
    // isApproved = json['isApproved'];
    // isPublished = json['isPublished'];
    // isActive = json['isActive'];
    // status = json['status'];
    createdAt = json['createdAt'];
    // updatedAt = json['updatedAt'];
    // user = json['User'];
    // newsCategory = json['NewsCategory'] != null
    //     ? NewsCategory.fromJson(json['NewsCategory'])
    //     : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['id'] = id;
    // data['categoryId'] = categoryId;
    // data['typeId'] = typeId;
    // data['createdBy'] = createdBy;
    data['title'] = title;
    data['shortDescription'] = shortDescription;
    // if (description != null) {
    //   data['description'] = description!.map((v) => v.toJson()).toList();
    // }
    // data['posterImage'] = posterImage;
    // data['isApproved'] = isApproved;
    // data['isPublished'] = isPublished;
    // data['isActive'] = isActive;
    // data['status'] = status;
    data['createdAt'] = createdAt;
    // data['updatedAt'] = updatedAt;
    // data['User'] = user;
    // if (newsCategory != null) {
    //   data['NewsCategory'] = newsCategory!.toJson();
    // }
    return data;
  }
}

