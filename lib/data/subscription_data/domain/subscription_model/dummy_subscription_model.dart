class DummySubscriptionNewsModel {
  int? id;
  String? name;
  String? amount;
  int? duration;
  List<String>? description;
  bool? isActive;
  bool? status;
  String? createdAt;
  String? updatedAt;

  DummySubscriptionNewsModel(
      {this.id,
        this.name,
        this.amount,
        this.duration,
        this.description,
        this.isActive,
        this.status,
        this.createdAt,
        this.updatedAt});

  DummySubscriptionNewsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    amount = json['amount'];
    duration = json['duration'];
    description = json['description']?.cast<String>();
    isActive = json['isActive'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['amount'] = amount;
    data['duration'] = duration;
    data['description'] = description;
    data['isActive'] = isActive;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
