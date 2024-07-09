import 'dart:convert';
import 'dart:io';

import 'package:at_your_home_partner/model/user_model.dart';
import 'package:at_your_home_partner/service/api_client.dart';
import 'package:at_your_home_partner/service/api_logs.dart';
import 'package:at_your_home_partner/service/api_url.dart';
import 'package:get/get_connect/connect.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService extends GetConnect {
  static var client = http.Client();

  static Future<http.Response> loginApi(
    String mobile,
    String password,
    String deviceKey,
  ) async {
    http.Response response;
    var result = await ApiClient.postData(ApiUrl.login, body: {
      'mobile_number': mobile.trim(),
      'password': password,
      'device_key': deviceKey,
    });
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  ///registerApi
  static Future<dynamic> registerApi(
    String aadharNo,
    String panNo,
    String medicalRegistrationNo,
    String educationNo,
    String aadharCardFront,
    String aadharCardBack,
    String panCard,
    String medicalRegistrationDoc,
    String educationDoc,
    String name,
    String mobile,
    String password,
    String businessName,
    String alternateMobile,
    String deviceKey,
    String experience,
    String addressLine,
    String pincode,
    String state,
    String city,
    String aboutVendor,
    String email,
  ) async {
    var result;
    http.Response response;
    try {
      var url = ApiUrl.register;
      Log.console('Http.Post Url: $url');
      http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(url));
      Log.console('Http.Post Headers: ${request.headers}');
      request.fields['aadhar_no'] = aadharNo.trim();
      request.fields['pan_no'] = panNo;
      request.fields['medical_registration_no'] = medicalRegistrationNo;
      request.fields['education_no'] = educationNo;
      request.fields['name'] = name.trim();
      request.fields['mobile_no'] = mobile.trim();
      request.fields['password'] = password;
      request.fields['business_name'] = businessName;
      request.fields['alternate_mobile'] = alternateMobile;
      request.fields['device_key'] = deviceKey;
      request.fields['experience'] = experience;
      request.fields['address_line_1'] = addressLine;
      request.fields['pincode'] = pincode;
      request.fields['state'] = state;
      request.fields['city'] = city;
      request.fields['about_vendor'] = aboutVendor;
      request.fields['email'] = email;
      if (aadharCardFront.isNotEmpty) {
        http.MultipartFile file = await http.MultipartFile.fromPath('aadhar_card_front', aadharCardFront);
        request.files.add(file);
      }
      if (aadharCardBack.isNotEmpty) {
        http.MultipartFile file = await http.MultipartFile.fromPath('aadhar_card_back', aadharCardBack);
        request.files.add(file);
      }
      if (panCard.isNotEmpty) {
        http.MultipartFile file = await http.MultipartFile.fromPath('pan_card', panCard);
        request.files.add(file);
      }
      if (medicalRegistrationDoc.isNotEmpty) {
        http.MultipartFile file = await http.MultipartFile.fromPath('medical_registration_doc', medicalRegistrationDoc);
        request.files.add(file);
      }
      if (educationDoc.isNotEmpty) {
        http.MultipartFile file = await http.MultipartFile.fromPath('education_doc', educationDoc);
        request.files.add(file);
      }
      Log.console('Http.Post filed: ${request.fields}');
      response = await http.Response.fromStream(await request.send());
      Log.console('Http.Response Body: ${response.body}');
      if (response.statusCode == 200) {
        result = jsonDecode(response.body);
      } else if (response.statusCode == 404) {
        result = {'status_code': 400, 'message': '404'};
      } else if (response.statusCode == 401) {
        result = jsonDecode(response.body);
      }
    } catch (e) {
      result = http.Response(
        jsonEncode({e.toString()}),
        204,
        headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
      );
    }
    return result;
  }

  static Future<http.Response> vendorOnOff() async {
    http.Response response;
    var pref = await SharedPreferences.getInstance();
    var crtData = pref.getString('currentUser');
    UserModel crtUser = UserModel.fromJson(jsonDecode(crtData!));
    var result = await ApiClient.postData(ApiUrl.vendorOnOff, body: {
      'user_id': crtUser.data!.id.toString(),
    });
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> vendorBooking(String serviceId) async {
    http.Response response;
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString('currentToken');
    var crtData = pref.getString('currentUser');
    UserModel crtUser = UserModel.fromJson(jsonDecode(crtData!));
    var result = await ApiClient.postData(ApiUrl.vendorBooking, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      'vendor_id': crtUser.data!.id.toString(),
      'service_id': serviceId,
    });
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> bookingDetails(String bookingId) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var crtData = instance.getString('currentUser');
    UserModel crtUser = UserModel.fromJson(jsonDecode(crtData!));
    var result = await ApiClient.postData(ApiUrl.bookingDetails, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      'user_id': crtUser.data!.id.toString(),
      'booking_id': bookingId,
    });
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> vendorChangePassword(
    String oldPassword,
    String password,
    String confirmPassword,
  ) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var crtData = instance.getString('currentUser');
    UserModel crtUser = UserModel.fromJson(jsonDecode(crtData!));
    var result = await ApiClient.postData(ApiUrl.vendorChangePassword, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      'user_id': crtUser.data!.id.toString(),
      'old_password': oldPassword,
      'password': password,
      'confirm_password': confirmPassword,
    });
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> vendorPasswordUpdate(
    String mobile,
    String password,
    String confirmPassword,
  ) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.vendorPasswordUpdate, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      'mobile': mobile,
      'password': password,
      'confirm_password': confirmPassword,
    });
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> forgotPassword(String mobile) async {
    http.Response response;
    var result = await ApiClient.postData(ApiUrl.forgotPassword, body: {'mobile': mobile.trim()});
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> verifyOtpApi(String mobile, String otp) async {
    http.Response response;
    var result = await ApiClient.postData(ApiUrl.verifyOtp, body: {'mobile': mobile.trim(), 'otp': otp.trim()});
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> cms(String type) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');

    var result = await ApiClient.postData(ApiUrl.vendorCms, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      'type': type,
    });
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  ///profileImage
  static Future<dynamic> profileImage(String profileImage) async {
    var result;
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var crtData = instance.getString('currentUser');
    var token = instance.getString('currentToken');
    UserModel crtUser = UserModel.fromJson(jsonDecode(crtData!));
    try {
      var url = ApiUrl.updateImageProfile;
      Log.console('Http.Post Url: $url');
      http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll({
        'Authorization': 'Bearer $token',
      });
      Log.console('Http.Post Headers: ${request.headers}');

      request.fields['user_id'] = crtUser.data!.id.toString();
      if (profileImage.isNotEmpty) {
        http.MultipartFile file = await http.MultipartFile.fromPath('profile_pic', profileImage);
        request.files.add(file);
      }
      Log.console('Http.Post filed: ${request.fields}');
      response = await http.Response.fromStream(await request.send());
      Log.console('Http.Response Body: ${response.body}');
      if (response.statusCode == 200) {
        result = jsonDecode(response.body);
      } else if (response.statusCode == 404) {
        result = {'status_code': 400, 'message': '404'};
      } else if (response.statusCode == 401) {
        result = jsonDecode(response.body);
      }
    } catch (e) {
      result = http.Response(
        jsonEncode({e.toString()}),
        204,
        headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
      );
    }
    return result;
  }

  static Future<http.Response> updateProfile(
    String name,
    String addressLine1,
    String pincode,
    String experience,
    String businessName,
    String alternateMobile,
    String state,
    String city,
  ) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var crtData = instance.getString('currentUser');
    UserModel crtUser = UserModel.fromJson(jsonDecode(crtData!));
    var result = await ApiClient.postData(ApiUrl.vendorUpdateProfile, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      'user_id': crtUser.data!.id.toString(),
      'name': name,
      'address_line_1': addressLine1,
      'pincode': pincode,
      'experience': experience,
      'business_name': businessName,
      'alternate_mobile': alternateMobile,
      'state': state,
      'city': city,
    });
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> vendorVendorDelete() async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var crtData = instance.getString('currentUser');
    UserModel crtUser = UserModel.fromJson(jsonDecode(crtData!));
    var result = await ApiClient.postData(ApiUrl.vendorVendorDelete, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      'vendor_id': crtUser.data!.vendorId.toString(),
    });
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> vendorGetProfile() async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var crtData = instance.getString('currentUser');
    UserModel crtUser = UserModel.fromJson(jsonDecode(crtData!));
    var result = await ApiClient.postData(ApiUrl.vendorGetProfile, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      'user_id': crtUser.data!.id.toString(),
    });
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> vendorBookingAccept(String bookingId, String status) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var crtData = instance.getString('currentUser');
    UserModel crtUser = UserModel.fromJson(jsonDecode(crtData!));
    var result = await ApiClient.postData(ApiUrl.vendorBookingAccept, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      'user_id': crtUser.data!.id.toString(),
      'booking_id': bookingId,
      'status': status,
    });
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> vendorCancelledBooking(String bookingId) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var crtData = instance.getString('currentUser');
    UserModel crtUser = UserModel.fromJson(jsonDecode(crtData!));
    var result = await ApiClient.postData(ApiUrl.vendorCancelledBooking, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      'user_id': crtUser.data!.id.toString(),
      'booking_id': bookingId,
    });
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> vendorAddBank(
    String bankName,
    String ifscCode,
    String accountNo,
    String branch,
    String holderName,
  ) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var crtData = instance.getString('currentUser');
    UserModel crtUser = UserModel.fromJson(jsonDecode(crtData!));
    var result = await ApiClient.postData(ApiUrl.vendorAddBank, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      'vendor_id': crtUser.data!.id.toString(),
      'bank_name': bankName,
      'ifsc_code': ifscCode,
      'account_no': accountNo,
      'branch': branch,
      'account_holder_name': holderName,
    });
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> vendorListBank() async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var crtData = instance.getString('currentUser');
    UserModel crtUser = UserModel.fromJson(jsonDecode(crtData!));
    var result = await ApiClient.postData(ApiUrl.vendorListBank, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      'vendor_id': crtUser.data!.id.toString(),
    });
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> vendorNotificationList() async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var crtData = instance.getString('currentUser');
    UserModel crtUser = UserModel.fromJson(jsonDecode(crtData!));
    var result = await ApiClient.postData(ApiUrl.vendorNotificationList, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      'user_id': crtUser.data!.id.toString(),
    });
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> vendorStartBooking() async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var crtData = instance.getString('currentUser');
    UserModel crtUser = UserModel.fromJson(jsonDecode(crtData!));
    var result = await ApiClient.postData(ApiUrl.vendorStartBooking, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      'vendor_id': crtUser.data!.id.toString(),
    });
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> vendorBookingOtp(String bookingId, String otp) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var crtData = instance.getString('currentUser');
    UserModel crtUser = UserModel.fromJson(jsonDecode(crtData!));
    var result = await ApiClient.postData(ApiUrl.vendorBookingOtp, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      'vendor_id': crtUser.data!.id.toString(),
      'booking_id': bookingId,
      'otp': otp,
    });
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> statesList() async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString("currentToken");
    var result = await ApiClient.postData(
      ApiUrl.statesList,
      headers: {
        "Authorization": "Bearer$token",
      },
      body: {
        'country_id': "105",
      },
    );
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> cityListGet(String stateId) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString("currentToken");

    var result = await ApiClient.postData(
      ApiUrl.cityList,
      headers: {
        "Authorization": "Bearer$token",
      },
      body: {
        'state_id': stateId,
      },
    );
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> allCategoryList() async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString("currentToken");
    var crtData = instance.getString('currentUser');
    UserModel crtUser = UserModel.fromJson(jsonDecode(crtData!));
    var result = await ApiClient.postData(
      ApiUrl.allCategoryList,
      headers: {
        "Authorization": "Bearer$token",
      },
      body: {
        'vendor_id': crtUser.data!.id.toString(),
      },
    );
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> subCategoryList(String categoryId) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString("currentToken");
    var crtData = instance.getString('currentUser');
    UserModel crtUser = UserModel.fromJson(jsonDecode(crtData!));
    var result = await ApiClient.postData(
      ApiUrl.subCategoryList,
      headers: {
        "Authorization": "Bearer$token",
      },
      body: {
        'category_id': categoryId,
      },
    );
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> serviceList(String categoryId, String subcategoryId) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString("currentToken");
    var crtData = instance.getString('currentUser');
    UserModel crtUser = UserModel.fromJson(jsonDecode(crtData!));
    var result = await ApiClient.postData(
      ApiUrl.serviceList,
      headers: {
        "Authorization": "Bearer$token",
      },
      body: {
        'vendor_id': crtUser.data!.id.toString(),
        'category_id': categoryId,
        'subcategory_id': subcategoryId,
      },
    );
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  ///createService
  static Future<dynamic> createService(
    var profileImage,
    String categoryId,
    String subcategoryId,
    var serviceId,
  ) async {
    var result;
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var crtData = instance.getString('currentUser');
    var token = instance.getString('currentToken');
    UserModel crtUser = UserModel.fromJson(jsonDecode(crtData!));
    try {
      var url = ApiUrl.createService;
      Log.console('Http.Post Url: $url');
      http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll({
        'Authorization': 'Bearer $token',
      });
      Log.console('Http.Post Headers: ${request.headers}');

      request.fields['user_id'] = crtUser.data!.id.toString();
      request.fields['category_id'] = categoryId;
      request.fields['subcategory_id'] = subcategoryId;
      if (profileImage.isNotEmpty) {
        for (int i = 0; i < profileImage.length; i++) {
          if (profileImage[i].toString() != "upload") {
            final File file = File(profileImage[i].path);
            http.MultipartFile file2 = await http.MultipartFile.fromPath("vendor_images", file.path.toString());
            request.files.add(file2);
          }
        }
      }
      if (serviceId.isNotEmpty) {
        for (int i = 0; i < serviceId.length; i++) {
          request.fields['service_id[]'] = serviceId[i];
        }
      }
      Log.console('Http.Post filed: ${request.fields}');
      response = await http.Response.fromStream(await request.send());
      Log.console('Http.Response Body: ${response.body}');
      if (response.statusCode == 200) {
        result = jsonDecode(response.body);
      } else if (response.statusCode == 404) {
        result = {'status_code': 400, 'message': '404'};
      } else if (response.statusCode == 401) {
        result = jsonDecode(response.body);
      }
    } catch (e) {
      result = http.Response(
        jsonEncode({e.toString()}),
        204,
        headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
      );
    }
    return result;
  }

  static Future<http.Response> timeSlotsList() async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString("currentToken");
    var crtData = instance.getString('currentUser');
    UserModel crtUser = UserModel.fromJson(jsonDecode(crtData!));
    var result = await ApiClient.postData(
      ApiUrl.timeSlotsList,
      headers: {
        "Authorization": "Bearer$token",
      },
      body: {},
    );
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> createTimeslots(String day, String timeSlots) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString("currentToken");
    var crtData = instance.getString('currentUser');
    UserModel crtUser = UserModel.fromJson(jsonDecode(crtData!));
    var requestBody = {'user_id': crtUser.data!.id.toString(), 'day': day, 'time_slots[]': timeSlots};
    var result = await ApiClient.postData(
      ApiUrl.createTimeslots,
      headers: {
        "Authorization": "Bearer $token",
      },
      body: requestBody,
    );
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> paymentHistory() async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString("currentToken");
    var crtData = instance.getString('currentUser');
    UserModel crtUser = UserModel.fromJson(jsonDecode(crtData!));
    var result = await ApiClient.postData(
      ApiUrl.paymentHistory,
      headers: {
        "Authorization": "Bearer$token",
      },
      body: {
        'user_id': crtUser.data!.id.toString(),
      },
    );
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> myService() async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString("currentToken");
    var crtData = instance.getString('currentUser');
    UserModel crtUser = UserModel.fromJson(jsonDecode(crtData!));
    var result = await ApiClient.postData(
      ApiUrl.myService,
      headers: {
        "Authorization": "Bearer$token",
      },
      body: {
        'user_id': crtUser.data!.id.toString(),
      },
    );
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> serviceDelete(String serviceId) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString("currentToken");
    var crtData = instance.getString('currentUser');
    UserModel crtUser = UserModel.fromJson(jsonDecode(crtData!));
    var result = await ApiClient.postData(
      ApiUrl.serviceDelete,
      headers: {
        "Authorization": "Bearer$token",
      },
      body: {
        'user_id': crtUser.data!.id.toString(),
        'service_id': serviceId,
      },
    );
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> serviceDetails(String serviceId) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString("currentToken");
    var crtData = instance.getString('currentUser');
    UserModel crtUser = UserModel.fromJson(jsonDecode(crtData!));
    var result = await ApiClient.postData(
      ApiUrl.serviceDetails,
      headers: {
        "Authorization": "Bearer$token",
      },
      body: {
        'user_id': crtUser.data!.id.toString(),
        'service_id': serviceId,
      },
    );
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> startBooking(String bookingId) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var crtData = instance.getString('currentUser');
    UserModel crtUser = UserModel.fromJson(jsonDecode(crtData!));
    var result = await ApiClient.postData(ApiUrl.startBooking, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      'user_id': crtUser.data!.id.toString(),
      'booking_id': bookingId,
    });
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> startBookingOtp(String bookingId, String otp) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var crtData = instance.getString('currentUser');
    UserModel crtUser = UserModel.fromJson(jsonDecode(crtData!));
    var result = await ApiClient.postData(ApiUrl.startBookingOtp, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      'user_id': crtUser.data!.id.toString(),
      'booking_id': bookingId,
      'otp': otp,
      'type': "start_otp",
    });
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> endBooking(String bookingId) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var crtData = instance.getString('currentUser');
    UserModel crtUser = UserModel.fromJson(jsonDecode(crtData!));
    var result = await ApiClient.postData(ApiUrl.endBooking, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      'user_id': crtUser.data!.id.toString(),
      'booking_id': bookingId,
    });
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> endBookingOtp(String bookingId, String otp) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var crtData = instance.getString('currentUser');
    UserModel crtUser = UserModel.fromJson(jsonDecode(crtData!));
    var result = await ApiClient.postData(ApiUrl.endBookingOtp, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      'user_id': crtUser.data!.id.toString(),
      'booking_id': bookingId,
      'otp': otp,
      'type': "end_otp",
    });
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }
}
