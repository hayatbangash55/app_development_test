class CategoryModel {
  String? categoryName;
  int? categoryId;

  CategoryModel({this.categoryName, this.categoryId});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    categoryName = json['categoryName'];
    categoryId = json['categoryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['categoryName'] = categoryName;
    data['categoryId'] = categoryId;
    return data;
  }
}
