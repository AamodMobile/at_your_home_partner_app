class UserModel {
  bool? status;
  UserData? data;
  String? message;

  UserModel({this.status, this.data, this.message});

  UserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class UserData {
  int? id;
  String? name;
  String? roleId;
  dynamic vendorId;
  String? mobile;
  String? email;
  String? pincode;
  String? profileImage;
  String? deviceKey;
  String? updatedAt;
  String? country;
  String? countryName;
  String? state;
  String? stateName;
  String? city;
  String? cityName;
  String? address;
  String? experience;
  String? alternateMobile;
  String? isAvaibility;
  String? businessName;
  dynamic addressLine2;
  String? token;

  UserData({
    this.id,
    this.name,
    this.roleId,
    this.vendorId,
    this.mobile,
    this.email,
    this.pincode,
    this.profileImage,
    this.deviceKey,
    this.updatedAt,
    this.country,
    this.countryName,
    this.state,
    this.stateName,
    this.city,
    this.cityName,
    this.address,
    this.experience,
    this.alternateMobile,
    this.isAvaibility,
    this.businessName,
    this.addressLine2,
    this.token,
  });

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] ?? "";
    roleId = json['role_id'] ?? "";
    vendorId = json['vendor_id'] ?? 0;
    mobile = json['mobile_no'] ?? "";
    email = json['email'] ?? "";
    pincode = json['pincode'] ?? "";
    profileImage = json['profile_image'] ?? "";
    deviceKey = json['device_key'] ?? "";
    updatedAt = json['updated_at'] ?? "";
    country = json['country'] ?? "";
    countryName = json['country_name'] ?? "";
    state = json['state'] ?? "";
    stateName = json['state_name'] ?? "";
    city = json['city'] ?? "";
    cityName = json['city_name'] ?? "";
    address = json['address'] ?? "";
    experience = json['experience'] ?? "";
    alternateMobile = json['alternate_mobile'] ?? "";
    isAvaibility = json['is_avaibility'] ?? "";
    businessName = json['business_name'] ?? "";
    addressLine2 = json['address_line_2'] ?? "";
    token = json['token'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = id;
    data['name'] = name;
    data['role_id'] = roleId;
    data['vendor_id'] = vendorId;
    data['mobile_no'] = mobile;
    data['email'] = email;
    data['pincode'] = pincode;
    data['profile_image'] = profileImage;
    data['device_key'] = deviceKey;
    data['updated_at'] = updatedAt;
    data['country'] = country;
    data['country_name'] = countryName;
    data['state'] = state;
    data['state_name'] = stateName;
    data['city'] = city;
    data['city_name'] = cityName;
    data['address'] = address;
    data['experience'] = experience;
    data['alternate_mobile'] = alternateMobile;
    data['is_avaibility'] = isAvaibility;
    data['business_name'] = businessName;
    data['address_line_2'] = addressLine2;
    data['token'] = token;
    return data;
  }
}
