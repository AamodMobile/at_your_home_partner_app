class BookingDetailsModel {
  int? id;
  String? userId;
  String? patientId;
  String? categoryId;
  String? subcategoryId;
  String? serviceId;
  String? servicePrice;
  String? serviceName;
  String? vendorId;
  String? bookingId;
  String? addressId;
  String? totalAmount;
  String? deliveryDate;
  String? deliveryTime;
  dynamic assignTo;
  String? status;
  dynamic cancellationUserId;
  dynamic cancellationVendorId;
  String? isBookingStarted;
  dynamic cancelledId;
  dynamic cancelledDate;
  dynamic paymentId;
  String? paymentType;
  dynamic isProduct;
  String? totalPaybleAmt;
  dynamic assignToStaff;
  String? isAccepted;
  dynamic currentLatitude;
  dynamic currentLongitude;
  dynamic updatedBy;
  dynamic roleId;
  dynamic feedback;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic couponCode;
  String? discountAmount;
  dynamic isWallet;
  dynamic walletAmount;
  dynamic startOtp;
  dynamic endOtp;
  dynamic startDate;
  dynamic endDate;
  dynamic serviceTime;
  dynamic extraTime;
  dynamic extraAmount;
  dynamic staffDetails;
  int? charge1;
  int? charge2;
  int? discount;
  int? addonService;
  int? itemTotal;
  List<dynamic>? bookingDetails;
  UserDetails? userDetails;
  AddressDetails? addressDetails;
  PatientDetails? patientDetails;
  String? serviceBannerImage;
  String? serviceImage;
  String? serviceSubDescription;

  BookingDetailsModel({
    this.id,
    this.userId,
    this.patientId,
    this.categoryId,
    this.subcategoryId,
    this.serviceId,
    this.servicePrice,
    this.serviceName,
    this.vendorId,
    this.bookingId,
    this.addressId,
    this.totalAmount,
    this.deliveryDate,
    this.deliveryTime,
    this.assignTo,
    this.status,
    this.cancellationUserId,
    this.cancellationVendorId,
    this.isBookingStarted,
    this.cancelledId,
    this.cancelledDate,
    this.paymentId,
    this.paymentType,
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
    this.charge1,
    this.charge2,
    this.discount,
    this.addonService,
    this.itemTotal,
    this.bookingDetails,
    this.userDetails,
    this.addressDetails,
    this.patientDetails,
    this.serviceBannerImage,
    this.serviceImage,
    this.serviceSubDescription,
  });

  factory BookingDetailsModel.fromJson(Map<String, dynamic> json) => BookingDetailsModel(
        id: json["id"],
        userId: json["user_id"],
        patientId: json["patient_id"],
        categoryId: json["category_id"],
        subcategoryId: json["subcategory_id"],
        serviceId: json["service_id"],
        servicePrice: json["service_price"],
        serviceName: json["service_name"],
        serviceImage: json["service_image"] ?? "",
        serviceBannerImage: json["service_banner_image"] ?? "",
        serviceSubDescription: json["service_sub_description"],
        vendorId: json["vendor_id"],
        bookingId: json["booking_id"],
        addressId: json["address_id"],
        totalAmount: json["total_amount"],
        deliveryDate: json["delivery_date"],
        deliveryTime: json["delivery_time"],
        assignTo: json["assign_to"],
        status: json["status"],
        cancellationUserId: json["cancellation_user_id"],
        cancellationVendorId: json["cancellation_vendor_id"],
        isBookingStarted: json["is_booking_started"],
        cancelledId: json["cancelled_id"],
        cancelledDate: json["cancelled_date"],
        paymentId: json["payment_id"],
        paymentType: json["payment_type"],
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
        endDate: json["end_date"],
        serviceTime: json["service_time"],
        extraTime: json["extra_time"],
        extraAmount: json["extra_amount"],
        staffDetails: json["staff_details"],
        charge1: json["charge_1"],
        charge2: json["charge_2"],
        discount: json["discount"],
        addonService: json["addon_service"],
        itemTotal: json["item_total"],
        bookingDetails: json["booking_details"] == null ? [] : List<dynamic>.from(json["booking_details"]!.map((x) => x)),
        userDetails: json["user_details"] == null ? null : UserDetails.fromJson(json["user_details"]),
        addressDetails: json["address_details"] == null ? null : AddressDetails.fromJson(json["address_details"]),
        patientDetails: json["patient_details"] == null ? null : PatientDetails.fromJson(json["patient_details"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "patient_id": patientId,
        "category_id": categoryId,
        "subcategory_id": subcategoryId,
        "service_id": serviceId,
        "service_price": servicePrice,
        "service_name": serviceName,
        "service_banner_image": serviceBannerImage,
        "service_image": serviceImage,
        "service_sub_description": serviceSubDescription,
        "vendor_id": vendorId,
        "booking_id": bookingId,
        "address_id": addressId,
        "total_amount": totalAmount,
        "delivery_date": deliveryDate,
        "delivery_time": deliveryTime,
        "assign_to": assignTo,
        "status": status,
        "cancellation_user_id": cancellationUserId,
        "cancellation_vendor_id": cancellationVendorId,
        "is_booking_started": isBookingStarted,
        "cancelled_id": cancelledId,
        "cancelled_date": cancelledDate,
        "payment_id": paymentId,
        "payment_type": paymentType,
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
        "end_date": endDate,
        "service_time": serviceTime,
        "extra_time": extraTime,
        "extra_amount": extraAmount,
        "staff_details": staffDetails,
        "charge_1": charge1,
        "charge_2": charge2,
        "discount": discount,
        "addon_service": addonService,
        "item_total": itemTotal,
        "booking_details": bookingDetails == null ? [] : List<dynamic>.from(bookingDetails!.map((x) => x)),
        "user_details": userDetails?.toJson(),
        "address_details": addressDetails?.toJson(),
        "patient_details": patientDetails?.toJson(),
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
  dynamic latitude;
  dynamic longitude;

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

class PatientDetails {
  int? id;
  String? userId;
  String? name;
  String? age;
  String? gender;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<PrescriptionImage>? prescriptionImage;

  PatientDetails({
    this.id,
    this.userId,
    this.name,
    this.age,
    this.gender,
    this.createdAt,
    this.updatedAt,
    this.prescriptionImage,
  });

  factory PatientDetails.fromJson(Map<String, dynamic> json) => PatientDetails(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        age: json["age"],
        gender: json["gender"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        prescriptionImage: json["prescription_image"] == null ? [] : List<PrescriptionImage>.from(json["prescription_image"]!.map((x) => PrescriptionImage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "age": age,
        "gender": gender,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "prescription_image": prescriptionImage == null ? [] : List<dynamic>.from(prescriptionImage!.map((x) => x)),
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

class PrescriptionImage {
  int? id;
  String? image;

  PrescriptionImage({
    this.id,
    this.image,
  });

  factory PrescriptionImage.fromJson(Map<String, dynamic> json) => PrescriptionImage(
        id: json["id"],
        image: json["image"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
      };
}
