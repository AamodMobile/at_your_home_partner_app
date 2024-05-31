

class BookingListModel {
  bool? status;
  List<BookingData>? data;

  BookingListModel({
    this.status,
    this.data,
  });

  factory BookingListModel.fromJson(Map<String, dynamic> json) => BookingListModel(
    status: json["status"],
    data: json["data"] == null ? [] : List<BookingData>.from(json["data"]!.map((x) => BookingData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class BookingData {
  int? id;
  dynamic cancelledDate;
  String? bookingId;
  String? categoryId;
  String? deliveryDate;
  String? totalAmount;
  String? status;
  String? addressId;
  DateTime? createdAt;
  dynamic updatedBy;
  String? serviceName;
  String? serviceImage;
  AddressDetails? addressDetails;

  BookingData({
    this.id,
    this.cancelledDate,
    this.bookingId,
    this.categoryId,
    this.deliveryDate,
    this.totalAmount,
    this.status,
    this.addressId,
    this.createdAt,
    this.updatedBy,
    this.serviceName,
    this.serviceImage,
    this.addressDetails,
  });

  factory BookingData.fromJson(Map<String, dynamic> json) => BookingData(
    id: json["id"],
    cancelledDate: json["cancelled_date"],
    bookingId: json["booking_id"],
    categoryId: json["category_id"],
    deliveryDate: json["delivery_date"],
    totalAmount: json["total_amount"]??"",
    status: json["status"],
    addressId: json["address_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedBy: json["updated_by"],
    serviceName: json["service_name"]??"",
    serviceImage: json["service_image"]??"",
    addressDetails: json["address_details"] == null ? null : AddressDetails.fromJson(json["address_details"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "cancelled_date": cancelledDate,
    "booking_id": bookingId,
    "category_id": categoryId,
    "delivery_date": deliveryDate,
    "total_amount": totalAmount,
    "status": status,
    "address_id": addressId,
    "created_at": createdAt?.toIso8601String(),
    "updated_by": updatedBy,
    "service_name": serviceName,
    "service_image": serviceImage,
    "address_details": addressDetails?.toJson(),
  };
}

class AddressDetails {
  int? id;
  String? houseNo;
  String? apartment;
  String? addressLine1;
  dynamic addressLine2;
  String? city;
  String? addressType;
  String? latitude;
  String? longitude;

  AddressDetails({
    this.id,
    this.houseNo,
    this.apartment,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.addressType,
    this.latitude,
    this.longitude,
  });

  factory AddressDetails.fromJson(Map<String, dynamic> json) => AddressDetails(
    id: json["id"],
    houseNo: json["house_no"],
    apartment: json["apartment"],
    addressLine1: json["address_line_1"],
    addressLine2: json["address_line_2"],
    city: json["city"],
    addressType: json["address_type"],
    latitude: json["latitude"],
    longitude: json["longitude"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "house_no": houseNo,
    "apartment": apartment,
    "address_line_1": addressLine1,
    "address_line_2": addressLine2,
    "city": city,
    "address_type": addressType,
    "latitude": latitude,
    "longitude": longitude,
  };
}
