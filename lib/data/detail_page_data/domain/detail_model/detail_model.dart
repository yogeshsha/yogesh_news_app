class DetailModel {
  int? id;
  int? categoryId;
  int? typeId;
  int? editorId;
  int? createdBy;
  // int? approvedBy;
  String? title;
  String? shortDescription;
  List<Description>? description;
  String? posterImage;
  // int? isApproved;
  // int? isPublished;
  // bool? isActive;
  // bool? status;
  String? createdAt;
  String? updatedAt;

  DetailModel(
      {this.id,
        this.categoryId,
        this.typeId,
        this.editorId,
        this.createdBy,
        // this.approvedBy,
        this.title,
        this.shortDescription,
        this.description,
        this.posterImage,
        // this.isApproved,
        // this.isPublished,
        // this.isActive,
        // this.status,
        this.createdAt,
        this.updatedAt});

  DetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['categoryId'];
    typeId = json['typeId'];
    editorId = json['editorId'];
    createdBy = json['createdBy'];
    // approvedBy = json['approvedBy'];
    title = json['title'];
    shortDescription = json['shortDescription'];
    if (json['description'] != null) {
      description = <Description>[];
      json['description'].forEach((v) {
        description!.add(Description.fromJson(v));
      });
    }
    posterImage = json['posterImage'];
    // isApproved = json['isApproved'];
    // isPublished = json['isPublished'];
    // isActive = json['isActive'];
    // status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['categoryId'] = categoryId;
    data['typeId'] = typeId;
    data['editorId'] = editorId;
    data['createdBy'] = createdBy;
    // data['approvedBy'] = approvedBy;
    data['title'] = title;
    data['shortDescription'] = shortDescription;
    if (description != null) {
      data['description'] = description!.map((v) => v.toJson()).toList();
    }
    data['posterImage'] = posterImage;
    // data['isApproved'] = isApproved;
    // data['isPublished'] = isPublished;
    // data['isActive'] = isActive;
    // data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Description {
  String? val;
  String? type;

  Description({this.val, this.type});

  Description.fromJson(Map<String, dynamic> json) {
    val = json['val'];
    val = val!.replaceAll("&lt;", "<");
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['val'] = val;
    data['type'] = type;
    return data;
  }
}
