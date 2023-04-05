class ProductModel {
  int? categoryId;
  String? image;
  String? price;
  String? subtitle;
  String? details;
  String? title;
  List<Colors>? colors;

  ProductModel(
      {this.categoryId,
        this.image,
      this.price,
      this.subtitle,
      this.details,
      this.title,
      this.colors});

  ProductModel.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    image = json['image'];
    price = json['price'];
    subtitle = json['subtitle'];
    details = json['details'];
    title = json['title'];
    if (json['colors'] != null) {
      colors = <Colors>[];
      json['colors'].forEach((v) {
        colors!.add( Colors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['categoryId'] = categoryId;
    data['image'] = image;
    data['price'] = price;
    data['subtitle'] = subtitle;
    data['details'] = details;
    data['title'] = title;
    if (colors != null) {
      data['colors'] = colors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Colors {
  String? colorName;
  String? colorCode;

  Colors({this.colorName, this.colorCode});

  Colors.fromJson(Map<String, dynamic> json) {
    colorName = json['colorName'];
    colorCode = json['colorCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['colorName'] = colorName;
    data['colorCode'] = colorCode;
    return data;
  }
}
