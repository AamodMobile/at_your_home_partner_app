import 'package:at_your_home_partner/model/my_feedback_list_model.dart';

class BookingDetailsModel {
  int? id;
  String? userId;
  String? patientId;
  String? categoryId;
  dynamic subcategoryId;
  dynamic serviceId;
  dynamic servicePrice;
  dynamic serviceName;
  String? vendorId;
  String? bookingId;
  String? addressId;
  String? totalAmount;
  String? gst;
  String? taxes;
  String? deliveryDate;
  String? deliveryTime;
  dynamic assignTo;
  String? status;
  dynamic cancellationUserId;
  dynamic cancellationVendorId;
  String? isBookingStarted;
  dynamic cancelledId;
  dynamic cancelledDate;
  String? paymentId;
  String? paymentStatus;
  String? transactionId;
  String? invoiceId;
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
  dynamic discountAmount;
  dynamic isWallet;
  dynamic walletAmount;
  String? startOtp;
  dynamic endOtp;
  dynamic startDate;
  dynamic endDate;
  dynamic serviceTime;
  dynamic extraTime;
  dynamic extraAmount;
  String? serviceBannerImage;
  String? serviceImage;
  String? serviceSubDescription;
  dynamic staffDetails;
  int? charge1;
  int? charge2;
  int? discount;
  int? addonService;
  int? itemTotal;
  List<BookingDetail>? bookingDetails;
  UserDetails? userDetails;
  AddressDetails? addressDetails;
  PatientDetails? patientDetails;
  RatingModelModel? ratings;
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
    this.gst,
    this.taxes,
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
    this.paymentStatus,
    this.transactionId,
    this.invoiceId,
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
    this.serviceBannerImage,
    this.serviceImage,
    this.serviceSubDescription,
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
    this.ratings,
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
    vendorId: json["vendor_id"],
    bookingId: json["booking_id"],
    addressId: json["address_id"],
    totalAmount: json["total_amount"],
    gst: json["gst"],
    taxes: json["taxes"],
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
    paymentStatus: json["payment_status"],
    transactionId: json["transaction_id"],
    invoiceId: json["invoice_id"],
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
    serviceBannerImage: json["service_banner_image"],
    serviceImage: json["service_image"],
    serviceSubDescription: json["service_sub_description"],
    staffDetails: json["staff_details"],
    charge1: json["charge_1"],
    charge2: json["charge_2"],
    discount: json["discount"],
    addonService: json["addon_service"],
    itemTotal: json["item_total"],
    bookingDetails: json["booking_details"] == null ? [] : List<BookingDetail>.from(json["booking_details"]!.map((x) => BookingDetail.fromJson(x))),
    userDetails: json["user_details"] == null ? null : UserDetails.fromJson(json["user_details"]),
    addressDetails: json["address_details"] == null ? null : AddressDetails.fromJson(json["address_details"]),
    patientDetails: json["patient_details"] == null ? null : PatientDetails.fromJson(json["patient_details"]),
    ratings: json["ratings"] == null ? null : RatingModelModel.fromJson(json["ratings"]),
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
    "vendor_id": vendorId,
    "booking_id": bookingId,
    "address_id": addressId,
    "total_amount": totalAmount,
    "gst": gst,
    "taxes": taxes,
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
    "payment_status": paymentStatus,
    "transaction_id": transactionId,
    "invoice_id": invoiceId,
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
    "service_banner_image": serviceBannerImage,
    "service_image": serviceImage,
    "service_sub_description": serviceSubDescription,
    "staff_details": staffDetails,
    "charge_1": charge1,
    "charge_2": charge2,
    "discount": discount,
    "addon_service": addonService,
    "item_total": itemTotal,
    "booking_details": bookingDetails == null ? [] : List<dynamic>.from(bookingDetails!.map((x) => x.toJson())),
    "user_details": userDetails?.toJson(),
    "address_details": addressDetails?.toJson(),
    "patient_details": patientDetails?.toJson(),
    "ratings": ratings?.toJson(),
  };
}

class AddressDetails {
  int? id;
  String? houseNo;
  String? apartment;
  String? addressLine1;
  String? addressLine2;
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

class BookingDetail {
  int? id;
  String? bookingId;
  String? serviceId;
  String? serviceName;
  String? quantity;
  String? price;
  Services? services;

  BookingDetail({
    this.id,
    this.bookingId,
    this.serviceId,
    this.serviceName,
    this.quantity,
    this.price,
    this.services,
  });

  factory BookingDetail.fromJson(Map<String, dynamic> json) => BookingDetail(
    id: json["id"],
    bookingId: json["booking_id"],
    serviceId: json["service_id"],
    serviceName: json["service_name"],
    quantity: json["quantity"],
    price: json["price"],
    services: json["services"] == null ? null : Services.fromJson(json["services"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "booking_id": bookingId,
    "service_id": serviceId,
    "service_name": serviceName,
    "quantity": quantity,
    "price": price,
    "services": services?.toJson(),
  };
}

class Services {
  int? id;
  String? languageId;
  dynamic vendorId;
  String? categoryId;
  String? categoryName;
  String? subcategoryId;
  String? subcategoryName;
  String? bannerImage;
  String? title;
  String? slug;
  dynamic link;
  String? image;
  String? status;
  String? subDescription;
  String? description;
  String? benefit;
  String? price;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic metaTitle;
  dynamic metaTag;
  dynamic metaDescription;

  Services({
    this.id,
    this.languageId,
    this.vendorId,
    this.categoryId,
    this.categoryName,
    this.subcategoryId,
    this.subcategoryName,
    this.bannerImage,
    this.title,
    this.slug,
    this.link,
    this.image,
    this.status,
    this.subDescription,
    this.description,
    this.benefit,
    this.price,
    this.createdAt,
    this.updatedAt,
    this.metaTitle,
    this.metaTag,
    this.metaDescription,
  });

  factory Services.fromJson(Map<String, dynamic> json) => Services(
    id: json["id"],
    languageId: json["language_id"],
    vendorId: json["vendor_id"],
    categoryId: json["category_id"],
    categoryName: json["category_name"],
    subcategoryId: json["subcategory_id"],
    subcategoryName: json["subcategory_name"],
    bannerImage: json["banner_image"],
    title: json["title"],
    slug: json["slug"],
    link: json["link"],
    image: json["image"],
    status: json["status"],
    subDescription: json["sub_description"],
    description: json["description"],
    benefit: json["benefit"],
    price: json["price"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    metaTitle: json["meta_title"],
    metaTag: json["meta_tag"],
    metaDescription: json["meta_description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "language_id": languageId,
    "vendor_id": vendorId,
    "category_id": categoryId,
    "category_name": categoryName,
    "subcategory_id": subcategoryId,
    "subcategory_name": subcategoryName,
    "banner_image": bannerImage,
    "title": title,
    "slug": slug,
    "link": link,
    "image": image,
    "status": status,
    "sub_description": subDescription,
    "description": description,
    "benefit": benefit,
    "price": price,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "meta_title": metaTitle,
    "meta_tag": metaTag,
    "meta_description": metaDescription,
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
    "prescription_image": prescriptionImage == null ? [] : List<dynamic>.from(prescriptionImage!.map((x) => x.toJson())),
  };
}

class PrescriptionImage {
  int? id;
  String? patientId;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;

  PrescriptionImage({
    this.id,
    this.patientId,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory PrescriptionImage.fromJson(Map<String, dynamic> json) => PrescriptionImage(
    id: json["id"],
    patientId: json["patient_id"],
    image: json["image"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "patient_id": patientId,
    "image": image,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class UserDetails {
  int? id;
  String? name;
  String? mobile;
  dynamic profilePic;
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
