class NotificationListModel {
  String? id;
  String? userId;
  String? title;
  String? image;
  String? description;
  String? bookingStatusCode;
  DateTime? createdAt;
  DateTime? updatedAt;

  NotificationListModel({
    this.id,
    this.userId,
    this.title,
    this.image,
    this.description,
    this.bookingStatusCode,
    this.createdAt,
    this.updatedAt,
  });

  factory NotificationListModel.fromJson(Map<String, dynamic> json) => NotificationListModel(
    id: json["id"],
    userId: json["user_id"],
    title: json["title"]??"",
    image: json["image"]??"",
    description: json["description"]??"",
    bookingStatusCode: json["booking_status_code"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "title": title,
    "description": description,
    "booking_status_code": bookingStatusCode,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
