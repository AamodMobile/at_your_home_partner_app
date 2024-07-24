
class PaymentModel {
  bool? status;
  dynamic dayIncome;
  String? weekIncome;
  String? monthIncome;
  List<PaymentHistoryModel>? data;

  PaymentModel({
    this.status,
    this.dayIncome,
    this.weekIncome,
    this.monthIncome,
    this.data,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
    status: json["status"],
    dayIncome: json["day_income"],
    weekIncome: json["week_income"],
    monthIncome: json["month_income"],
    data: json["data"] == null ? [] : List<PaymentHistoryModel>.from(json["data"]!.map((x) => PaymentHistoryModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "day_income": dayIncome,
    "week_income": weekIncome,
    "month_income": monthIncome,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class PaymentHistoryModel {
  int? id;
  String? vendorId;
  String? bookingId;
  String? commision;
  String? commisionAmount;
  DateTime? createdAt;
  DateTime? updatedAt;
  BookingDetail? bookingDetail;

  PaymentHistoryModel({
    this.id,
    this.vendorId,
    this.bookingId,
    this.commision,
    this.commisionAmount,
    this.createdAt,
    this.updatedAt,
    this.bookingDetail,
  });

  factory PaymentHistoryModel.fromJson(Map<String, dynamic> json) => PaymentHistoryModel(
    id: json["id"],
    vendorId: json["vendor_id"],
    bookingId: json["booking_id"],
    commision: json["commision"],
    commisionAmount: json["commision_amount"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    bookingDetail: json["booking_detail"] == null ? null : BookingDetail.fromJson(json["booking_detail"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "vendor_id": vendorId,
    "booking_id": bookingId,
    "commision": commision,
    "commision_amount": commisionAmount,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "booking_detail": bookingDetail?.toJson(),
  };
}

class BookingDetail {
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
  String? endOtp;
  dynamic startDate;
  dynamic endDate;
  dynamic serviceTime;
  dynamic extraTime;
  dynamic extraAmount;
  Category? category;

  BookingDetail({
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
    this.category,
  });

  factory BookingDetail.fromJson(Map<String, dynamic> json) => BookingDetail(
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
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
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
    "category": category?.toJson(),
  };
}

class Category {
  int? id;
  String? languageId;
  String? title;
  String? image;
  String? bannerImage;
  String? note;
  String? status;
  dynamic icon;
  dynamic link;
  String? sortOrder;
  dynamic description;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic metaTitle;
  dynamic metaTag;
  dynamic metaDescription;
  String? slug;

  Category({
    this.id,
    this.languageId,
    this.title,
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
    this.metaTitle,
    this.metaTag,
    this.metaDescription,
    this.slug,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    languageId: json["language_id"],
    title: json["title"],
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
    metaTitle: json["meta_title"],
    metaTag: json["meta_tag"],
    metaDescription: json["meta_description"],
    slug: json["slug"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "language_id": languageId,
    "title": title,
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
    "meta_title": metaTitle,
    "meta_tag": metaTag,
    "meta_description": metaDescription,
    "slug": slug,
  };
}

