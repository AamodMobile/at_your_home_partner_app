class ServiceDetailsModel {
  int? id;
  String? vendorId;
  String? businessName;
  dynamic aboutVendor;
  String? medicalRegistration;
  ServiceDetail? serviceDetail;
  TimeSlots? timeSlots;
  List<dynamic>? vendorImages;
  List<dynamic>? reviews;

  ServiceDetailsModel({
    this.id,
    this.vendorId,
    this.businessName,
    this.aboutVendor,
    this.medicalRegistration,
    this.serviceDetail,
    this.timeSlots,
    this.vendorImages,
    this.reviews,
  });

  factory ServiceDetailsModel.fromJson(Map<String, dynamic> json) => ServiceDetailsModel(
    id: json["id"],
    vendorId: json["vendor_id"],
    businessName: json["business_name"],
    aboutVendor: json["about_vendor"],
    medicalRegistration: json["medical_registration"],
    serviceDetail: json["service_detail"] == null ? null : ServiceDetail.fromJson(json["service_detail"]),
    timeSlots: json["time_slots"] == null ? null : TimeSlots.fromJson(json["time_slots"]),
    vendorImages: json["vendor_images"] == null ? [] : List<dynamic>.from(json["vendor_images"]!.map((x) => x)),
    reviews: json["reviews"] == null ? [] : List<dynamic>.from(json["reviews"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "vendor_id": vendorId,
    "business_name": businessName,
    "about_vendor": aboutVendor,
    "medical_registration": medicalRegistration,
    "service_detail": serviceDetail?.toJson(),
    "time_slots": timeSlots?.toJson(),
    "vendor_images": vendorImages == null ? [] : List<dynamic>.from(vendorImages!.map((x) => x)),
    "reviews": reviews == null ? [] : List<dynamic>.from(reviews!.map((x) => x)),
  };
}

class ServiceDetail {
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

  ServiceDetail({
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

  factory ServiceDetail.fromJson(Map<String, dynamic> json) => ServiceDetail(
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

class TimeSlots {
  int? id;
  String? vendorId;
  String? sun;
  String? mon;
  dynamic tue;
  dynamic wed;
  dynamic thu;
  String? fri;
  dynamic sat;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Slot>? sunSlots;
  List<Slot>? monSlots;
  dynamic tueSlots;
  dynamic wedSlots;
  dynamic thuSlots;
  List<Slot>? friSlots;
  dynamic satSlots;

  TimeSlots({
    this.id,
    this.vendorId,
    this.sun,
    this.mon,
    this.tue,
    this.wed,
    this.thu,
    this.fri,
    this.sat,
    this.createdAt,
    this.updatedAt,
    this.sunSlots,
    this.monSlots,
    this.tueSlots,
    this.wedSlots,
    this.thuSlots,
    this.friSlots,
    this.satSlots,
  });

  factory TimeSlots.fromJson(Map<String, dynamic> json) => TimeSlots(
    id: json["id"],
    vendorId: json["vendor_id"],
    sun: json["sun"],
    mon: json["mon"],
    tue: json["tue"],
    wed: json["wed"],
    thu: json["thu"],
    fri: json["fri"],
    sat: json["sat"],
    sunSlots: json["sun_slots"] == null ? [] : List<Slot>.from(json["sun_slots"]!.map((x) => Slot.fromJson(x))),
    monSlots: json["mon_slots"] == null ? [] : List<Slot>.from(json["mon_slots"]!.map((x) => Slot.fromJson(x))),
    tueSlots: json["tue_slots"],
    wedSlots: json["wed_slots"],
    thuSlots: json["thu_slots"],
    friSlots: json["fri_slots"] == null ? [] : List<Slot>.from(json["fri_slots"]!.map((x) => Slot.fromJson(x))),
    satSlots: json["sat_slots"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "vendor_id": vendorId,
    "sun": sun,
    "mon": mon,
    "tue": tue,
    "wed": wed,
    "thu": thu,
    "fri": fri,
    "sat": sat,
    "sun_slots": sunSlots == null ? [] : List<dynamic>.from(sunSlots!.map((x) => x.toJson())),
    "mon_slots": monSlots == null ? [] : List<dynamic>.from(monSlots!.map((x) => x.toJson())),
    "tue_slots": tueSlots,
    "wed_slots": wedSlots,
    "thu_slots": thuSlots,
    "fri_slots": friSlots == null ? [] : List<dynamic>.from(friSlots!.map((x) => x.toJson())),
    "sat_slots": satSlots,
  };
}

class Slot {
  int? id;
  dynamic daySlotId;
  String? timeslots;
  dynamic metaTitle;
  dynamic metaTag;
  dynamic metaDescription;
  dynamic slug;
  String? status;

  Slot({
    this.id,
    this.daySlotId,
    this.timeslots,
    this.metaTitle,
    this.metaTag,
    this.metaDescription,
    this.slug,
    this.status,
  });

  factory Slot.fromJson(Map<String, dynamic> json) => Slot(
    id: json["id"],
    daySlotId: json["day_slot_id"],
    timeslots: json["timeslots"],
    metaTitle: json["meta_title"],
    metaTag: json["meta_tag"],
    metaDescription: json["meta_description"],
    slug: json["slug"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "day_slot_id": daySlotId,
    "timeslots": timeslots,
    "meta_title": metaTitle,
    "meta_tag": metaTag,
    "meta_description": metaDescription,
    "slug": slug,
    "status": status,
  };
}
