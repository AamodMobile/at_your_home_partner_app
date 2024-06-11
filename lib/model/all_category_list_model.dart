class AllCategoryListModel {
  String? languageId;
  String? image;
  String? bannerImage;
  String? note;
  String? status;
  String? icon;
  dynamic link;
  String? sortOrder;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? quantity;
  dynamic isChecked;
  int? value;
  String? label;

  AllCategoryListModel({
    this.languageId,
    this.image,
    this.bannerImage,
    this.note,
    this.status,
    this.icon,
    this.link,
    this.sortOrder,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.quantity,
    this.isChecked,
    this.value,
    this.label,
  });

  factory AllCategoryListModel.fromJson(Map<String, dynamic> json) => AllCategoryListModel(
    languageId: json["language_id"],
    image: json["image"],
    bannerImage: json["banner_image"],
    note: json["note"],
    status: json["status"],
    icon: json["icon"],
    link: json["link"],
    sortOrder: json["sort_order"],
    description: json["description"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    quantity: json["quantity"],
    isChecked: json["is_checked"],
    value: json["value"],
    label: json["label"],
  );

  Map<String, dynamic> toJson() => {
    "language_id": languageId,
    "image": image,
    "banner_image": bannerImage,
    "note": note,
    "status": status,
    "icon": icon,
    "link": link,
    "sort_order": sortOrder,
    "description": description,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "quantity": quantity,
    "is_checked": isChecked,
    "value": value,
    "label": label,
  };
}
