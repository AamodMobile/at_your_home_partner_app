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
    String vendorId,
    String mobile,
    String password,
    String deviceKey,
  ) async {
    http.Response response;
    var result = await ApiClient.postData(ApiUrl.login, body: {
      'vendor_id': vendorId,
      'mobile_number': mobile.trim(),
      'password': password,
      'device_key': deviceKey,
    });
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> registerApi(
    String name,
    String mobile,
    String password,
    String businessName,
    String alternateMobile,
    String deviceKey,
    String experience,
    String addressLine,
    String pincode,
  ) async {
    http.Response response;
    var result = await ApiClient.postData(ApiUrl.register, body: {
      'name': name.trim(),
      'mobile_no': mobile.trim(),
      'password': password,
      'business_name': businessName,
      'alternate_mobile': alternateMobile,
      'device_key': deviceKey,
      'experience': experience,
      'address_line_1': addressLine,
      'pincode': pincode,
    });
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
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

  static Future<http.Response> vendorBooking() async {
    http.Response response;
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString('currentToken');
    var crtData = pref.getString('currentUser');
    UserModel crtUser = UserModel.fromJson(jsonDecode(crtData!));
    var result = await ApiClient.postData(ApiUrl.vendorBooking, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      'vendor_id': crtUser.data!.id.toString(),
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

  static Future<http.Response> cancelledBooking(String bookingId) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var crtData = instance.getString('currentUser');
    UserModel crtUser = UserModel.fromJson(jsonDecode(crtData!));
    var result = await ApiClient.postData(ApiUrl.cancelledBooking, headers: {
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
  static Future<http.Response> vendorBookingOtp(String bookingId,String otp ) async {
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
}
