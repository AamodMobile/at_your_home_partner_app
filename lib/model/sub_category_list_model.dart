class SubCategoryListModel {
  String? languageId;
  String? categoryId;
  String? categoryName;
  String? image;
  String? bannerImage;
  dynamic link;
  String? note;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? quantity;
  String? icon;
  int? value;
  String? label;

  SubCategoryListModel({
    this.languageId,
    this.categoryId,
    this.categoryName,
    this.image,
    this.bannerImage,
    this.link,
    this.note,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.quantity,
    this.icon,
    this.value,
    this.label,
  });

  factory SubCategoryListModel.fromJson(Map<String, dynamic> json) => SubCategoryListModel(
    languageId: json["language_id"],
    categoryId: json["category_id"],
    categoryName: json["category_name"],
    image: json["image"],
    bannerImage: json["banner_image"],
    link: json["link"],
    note: json["note"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    quantity: json["quantity"],
    icon: json["icon"],
    value: json["value"],
    label: json["label"],
  );

  Map<String, dynamic> toJson() => {
    "language_id": languageId,
    "category_id": categoryId,
    "category_name": categoryName,
    "image": image,
    "banner_image": bannerImage,
    "link": link,
    "note": note,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "quantity": quantity,
    "icon": icon,
    "value": value,
    "label": label,
  };
}
