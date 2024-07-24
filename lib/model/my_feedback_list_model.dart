class RatingModelModel {
  int? id;
  String? vendorId;
  String? bookingId;
  String? userId;
  String? rating;
  String? title;
  String? description;
  String? approve;
  String? createdAt;
  DateTime? updatedAt;
  List<ServiceDetail>? serviceDetails;
  UserData? userData;

  RatingModelModel({
    this.id,
    this.vendorId,
    this.bookingId,
    this.userId,
    this.rating,
    this.title,
    this.description,
    this.approve,
    this.createdAt,
    this.updatedAt,
    this.serviceDetails,
    this.userData,
  });

  factory RatingModelModel.fromJson(Map<String, dynamic> json) => RatingModelModel(
        id: json["id"],
        vendorId: json["vendor_id"],
        bookingId: json["booking_id"],
        userId: json["user_id"],
        rating: json["rating"],
        title: json["title"],
        description: json["description"],
        approve: json["approve"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        serviceDetails: json["service_details"] == null ? [] : List<ServiceDetail>.from(json["service_details"]!.map((x) => ServiceDetail.fromJson(x))),
        userData: json["user_data"] == null ? null : UserData.fromJson(json["user_data"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "vendor_id": vendorId,
        "booking_id": bookingId,
        "user_id": userId,
        "rating": rating,
        "title": title,
        "description": description,
        "approve": approve,
        "created_at": createdAt,
        "updated_at": updatedAt?.toIso8601String(),
        "service_details": serviceDetails == null ? [] : List<dynamic>.from(serviceDetails!.map((x) => x.toJson())),
        "user_data": userData?.toJson(),
      };
}

class ServiceDetail {
  int? id;
  String? title;

  ServiceDetail({
    this.id,
    this.title,
  });

  factory ServiceDetail.fromJson(Map<String, dynamic> json) => ServiceDetail(
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
      };
}

class UserData {
  int? id;
  String? name;
  String? mobile;
  String? profilePic;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserData({
    this.id,
    this.name,
    this.mobile,
    this.profilePic,
    this.createdAt,
    this.updatedAt,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["id"],
        name: json["name"],
        mobile: json["mobile"],
        profilePic: json["profile_pic"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "mobile": mobile,
        "profile_pic": profilePic,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
