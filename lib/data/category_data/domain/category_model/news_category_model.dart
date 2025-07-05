class NewsCategoryModel {
  int? id;
  String? image;
  String? name;
  String? hindiName;

  NewsCategoryModel({this.id, this.image, this.name, this.hindiName});

  NewsCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    hindiName = json['hindiName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['name'] = name;
    data['hindiName'] = hindiName;
    return data;
  }
}
