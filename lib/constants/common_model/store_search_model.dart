class StoreSearchModel {
  int? tableId;
  String title = "";
  String subTitle= "";

  StoreSearchModel({
    this.tableId,
    required this.title,
    required this.subTitle,
  });
  StoreSearchModel.fromJson(Map<String, dynamic> value) {
    tableId = value['tableId'];
    title = value['title'] ?? "";
    subTitle = value['subTitle'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['subTitle'] = subTitle;
    return data;
  }
}
