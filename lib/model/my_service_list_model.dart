class MyServiceListModel {
  int? id;
  String? categoryId;
  String? categoryName;
  String? subcategoryId;
  String? subcategoryName;
  String? bannerImage;
  String? title;
  String? subDescription;
  String? price;
  String? status;

  MyServiceListModel({
    this.id,
    this.categoryId,
    this.categoryName,
    this.subcategoryId,
    this.subcategoryName,
    this.bannerImage,
    this.title,
    this.subDescription,
    this.price,
    this.status,
  });

  factory MyServiceListModel.fromJson(Map<String, dynamic> json) => MyServiceListModel(
    id: json["id"],
    categoryId: json["category_id"],
    categoryName: json["category_name"],
    subcategoryId: json["subcategory_id"],
    subcategoryName: json["subcategory_name"],
    bannerImage: json["banner_image"],
    title: json["title"],
    subDescription: json["sub_description"],
    price: json["price"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "category_name": categoryName,
    "subcategory_id": subcategoryId,
    "subcategory_name": subcategoryName,
    "banner_image": bannerImage,
    "title": title,
    "sub_description": subDescription,
    "price": price,
    "status": status,
  };
}
