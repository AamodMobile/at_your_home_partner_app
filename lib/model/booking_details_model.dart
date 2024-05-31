

class BookingDetailsModel {
  int? id;
  String? userId;
  String? categoryId;
  String? userName;
  String? age;
  String? gender;
  String? prescription;
  String? vendorId;
  String? bookingId;
  String? addressId;
  String? totalAmount;
  String? deliveryDate;
  String? deliveryTime;
  String? assignTo;
  String? status;
  String? isBookingStarted;
  dynamic cancelledId;
  dynamic cancelledDate;
  dynamic paymentId;
  String? paymentType;
  int? charge1;
  int? charge2;
  dynamic isProduct;
  String? totalPaybleAmt;
  dynamic assignToStaff;
  String? isAccepted;
  dynamic currentLatitude;
  dynamic currentLongitude;
  String? updatedBy;
  String? roleId;
  dynamic feedback;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic couponCode;
  String? discountAmount;
  dynamic isWallet;
  dynamic walletAmount;
  dynamic startOtp;
  String? endOtp;
  dynamic startDate;
  DateTime? endDate;
  String? serviceTime;
  String? extraTime;
  String? extraAmount;
  dynamic staffDetails;
  int? discount;
  int? addonService;
  int? itemTotal;
  List<BookingDetail>? bookingDetails;
  UserDetails? userDetails;
  AddressDetails? addressDetails;

  BookingDetailsModel({
    this.id,
    this.userId,
    this.categoryId,
    this.userName,
    this.age,
    this.gender,
    this.prescription,
    this.vendorId,
    this.bookingId,
    this.addressId,
    this.totalAmount,
    this.deliveryDate,
    this.deliveryTime,
    this.assignTo,
    this.status,
    this.isBookingStarted,
    this.cancelledId,
    this.cancelledDate,
    this.paymentId,
    this.paymentType,
    this.charge1,
    this.charge2,
    this.isProduct,
    this.totalPaybleAmt,
    this.assignToStaff,
    this.isAccepted,
    this.currentLatitude,
    this.currentLongitude,
    this.updatedBy,
    this.roleId,
    this.feedback,
    this.createdAt,
    this.updatedAt,
    this.couponCode,
    this.discountAmount,
    this.isWallet,
    this.walletAmount,
    this.startOtp,
    this.endOtp,
    this.startDate,
    this.endDate,
    this.serviceTime,
    this.extraTime,
    this.extraAmount,
    this.staffDetails,
    this.discount,
    this.addonService,
    this.itemTotal,
    this.bookingDetails,
    this.userDetails,
    this.addressDetails,
  });

  factory BookingDetailsModel.fromJson(Map<String, dynamic> json) => BookingDetailsModel(
    id: json["id"],
    userId: json["user_id"],
    categoryId: json["category_id"],
    userName: json["user_name"],
    age: json["age"],
    gender: json["gender"],
    prescription: json["prescription"],
    vendorId: json["vendor_id"],
    bookingId: json["booking_id"],
    addressId: json["address_id"],
    totalAmount: json["total_amount"],
    deliveryDate: json["delivery_date"],
    deliveryTime: json["delivery_time"],
    assignTo: json["assign_to"],
    status: json["status"],
    isBookingStarted: json["is_booking_started"],
    cancelledId: json["cancelled_id"],
    cancelledDate: json["cancelled_date"],
    paymentId: json["payment_id"],
    paymentType: json["payment_type"],
    charge1: json["charge_1"],
    charge2: json["charge_2"],
    isProduct: json["is_product"],
    totalPaybleAmt: json["total_payble_amt"],
    assignToStaff: json["assign_to_staff"],
    isAccepted: json["is_accepted"],
    currentLatitude: json["current_latitude"],
    currentLongitude: json["current_longitude"],
    updatedBy: json["updated_by"],
    roleId: json["role_id"],
    feedback: json["feedback"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    couponCode: json["coupon_code"],
    discountAmount: json["discount_amount"],
    isWallet: json["is_wallet"],
    walletAmount: json["wallet_amount"],
    startOtp: json["start_otp"],
    endOtp: json["end_otp"],
    startDate: json["start_date"],
    endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
    serviceTime: json["service_time"],
    extraTime: json["extra_time"],
    extraAmount: json["extra_amount"],
    staffDetails: json["staff_details"],
    discount: json["discount"],
    addonService: json["addon_service"],
    itemTotal: json["item_total"],
    bookingDetails: json["booking_details"] == null ? [] : List<BookingDetail>.from(json["booking_details"]!.map((x) => BookingDetail.fromJson(x))),
    userDetails: json["user_details"] == null ? null : UserDetails.fromJson(json["user_details"]),
    addressDetails: json["address_details"] == null ? null : AddressDetails.fromJson(json["address_details"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "category_id": categoryId,
    "user_name": userName,
    "age": age,
    "gender": gender,
    "prescription": prescription,
    "vendor_id": vendorId,
    "booking_id": bookingId,
    "address_id": addressId,
    "total_amount": totalAmount,
    "delivery_date": deliveryDate,
    "delivery_time": deliveryTime,
    "assign_to": assignTo,
    "status": status,
    "is_booking_started": isBookingStarted,
    "cancelled_id": cancelledId,
    "cancelled_date": cancelledDate,
    "payment_id": paymentId,
    "payment_type": paymentType,
    "charge_1": charge1,
    "charge_2": charge2,
    "is_product": isProduct,
    "total_payble_amt": totalPaybleAmt,
    "assign_to_staff": assignToStaff,
    "is_accepted": isAccepted,
    "current_latitude": currentLatitude,
    "current_longitude": currentLongitude,
    "updated_by": updatedBy,
    "role_id": roleId,
    "feedback": feedback,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "coupon_code": couponCode,
    "discount_amount": discountAmount,
    "is_wallet": isWallet,
    "wallet_amount": walletAmount,
    "start_otp": startOtp,
    "end_otp": endOtp,
    "start_date": startDate,
    "end_date": endDate?.toIso8601String(),
    "service_time": serviceTime,
    "extra_time": extraTime,
    "extra_amount": extraAmount,
    "staff_details": staffDetails,
    "discount": discount,
    "addon_service": addonService,
    "item_total": itemTotal,
    "booking_details": bookingDetails == null ? [] : List<dynamic>.from(bookingDetails!.map((x) => x.toJson())),
    "user_details": userDetails?.toJson(),
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

class BookingDetail {
  int? id;
  String? bookingId;
  String? serviceId;
  String? serviceName;
  String? quantity;
  String? price;

  BookingDetail({
    this.id,
    this.bookingId,
    this.serviceId,
    this.serviceName,
    this.quantity,
    this.price,
  });

  factory BookingDetail.fromJson(Map<String, dynamic> json) => BookingDetail(
    id: json["id"],
    bookingId: json["booking_id"],
    serviceId: json["service_id"],
    serviceName: json["service_name"],
    quantity: json["quantity"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "booking_id": bookingId,
    "service_id": serviceId,
    "service_name": serviceName,
    "quantity": quantity,
    "price": price,
  };
}

class UserDetails {
  int? id;
  String? name;
  String? mobile;
  String? profilePic;
  String? profileImage;

  UserDetails({
    this.id,
    this.name,
    this.mobile,
    this.profilePic,
    this.profileImage,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
    id: json["id"],
    name: json["name"],
    mobile: json["mobile"],
    profilePic: json["profile_pic"],
    profileImage: json["profile_image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "mobile": mobile,
    "profile_pic": profilePic,
    "profile_image": profileImage,
  };
}
