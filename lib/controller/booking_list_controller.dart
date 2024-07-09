import 'dart:convert';

import 'package:at_your_home_partner/constants/constants.dart';
import 'package:at_your_home_partner/model/booking_details_model.dart';
import 'package:at_your_home_partner/model/booking_list_model.dart';
import 'package:at_your_home_partner/service/api_logs.dart';
import 'package:at_your_home_partner/service/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingListController extends GetxController implements GetxService {
  bool isLoading = false;
  var bookingList = <BookingData>[];
  var bookingListService = <BookingData>[];
  var pendingList = <BookingData>[];
  var completedList = <BookingData>[];
  var cancelledList = <BookingData>[];
  int selectedIndex = 0;
  var bookingDetailsModel = BookingDetailsModel().obs;
  var isAvailabilityStatus = "0".obs;

  Future<void> getBookingList(String serviceId) async {
    try {
      isLoading = true;
      bookingList.clear();
      pendingList.clear();
      completedList.clear();
      cancelledList.clear();
      var result = await ApiService.vendorBooking(serviceId);
      var json = jsonDecode(result.body);
      var apiResponse = BookingListModel.fromJson(json);
      if (apiResponse.status!) {
        bookingList = apiResponse.data!;
        for (int i = 0; i < bookingList.length; i++) {
          if (bookingList[i].status == "pending") {
            pendingList.add(bookingList[i]);
          } else if (bookingList[i].status == "complete") {
            completedList.add(bookingList[i]);
          } else if (bookingList[i].status == "cancelled") {
            cancelledList.add(bookingList[i]);
          }
        }
        isLoading = false;
      } else {
        isLoading = false;
        errorToast("Booking list not found");
      }

    } catch (e) {
      isLoading = false;
      Log.console(e.toString());
    }
    update();
  }

  Future<void> getBookingServiceList(String serviceId) async {
    isLoading = true;
    try {
      bookingListService.clear();
      var result = await ApiService.vendorBooking(serviceId);
      var json = jsonDecode(result.body);
      var apiResponse = BookingListModel.fromJson(json);
      if (apiResponse.status!) {
        bookingListService = apiResponse.data!;
      } else {
        errorToast("Booking list not found");
      }
      isLoading = false;
    } catch (e) {
      bookingListService.clear();
      isLoading = false;
      Log.console(e.toString());
    }
    update();
  }

  Future<void> bookingDetails(String bookingId) async {
  //  try {
      isLoading = true;
      var result = await ApiService.bookingDetails(bookingId);
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        isLoading = false;
        bookingDetailsModel.value = BookingDetailsModel.fromJson(json["data"]);
        successToast("Booking Details Get");
      } else {
        isLoading = false;
        errorToast(json["message"].toString());
      }
    //} catch (e) {
     // isLoading = false;
   //   Log.console(e.toString());
   // }
    update();
  }


  Future<void> vendorBookingAccept(String bookingId, String status) async {
    try {
      showProgress();
      var result = await ApiService.vendorBookingAccept(bookingId, status);
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        closeProgress();
        getBookingList("");
        bookingDetails(bookingId);
        successToast("Booking Details Get");
      } else {
        closeProgress();
        errorToast(json["message"].toString());
      }
    } catch (e) {
      closeProgress();
      Log.console(e.toString());
    }
    update();
  }
  Future<void> vendorCancelledBooking(String bookingId) async {
    try {
      showProgress();
      var result = await ApiService.vendorCancelledBooking(bookingId);
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        closeProgress();
        getBookingList("");
        bookingDetails(bookingId);
        successToast("Booking Details Get");
      } else {
        closeProgress();
        errorToast(json["message"].toString());
      }
    } catch (e) {
      closeProgress();
      Log.console(e.toString());
    }
    update();
  }
  Future<void> vendorOnOff() async {
    try {
      showProgress();
      var result = await ApiService.vendorOnOff();
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        closeProgress();
        successToast(json["message"].toString());
        var pref = await SharedPreferences.getInstance();
        await pref.setString('isAvailability', json["is_avaibility"].toString());
        await pref.reload();
        isAvailabilityStatus.value = pref.getString("isAvailability").toString();
      } else {
        closeProgress();
        errorToast(json["message"].toString());
      }
    } catch (e) {
      closeProgress();
      Log.console(e.toString());
    }
  }

  Future<void> vendorStartBooking(String bookingId) async {
    try {
      showProgress();
      var result = await ApiService.vendorStartBooking();
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        closeProgress();
        getBookingList("");
        bookingDetails(bookingId);

      } else {
        closeProgress();
        errorToast(json["message"].toString());
      }
    } catch (e) {
      closeProgress();
      Log.console(e.toString());
    }
    update();
  }

  Future<void> vendorBookingOtp(String bookingId, String otp) async {
    try {
      showProgress();
      var result = await ApiService.vendorBookingOtp(bookingId, otp);
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        closeProgress();
        getBookingList("");
        bookingDetails(bookingId);
        successToast("Booking Details Get");
      } else {
        closeProgress();
        errorToast(json["message"].toString());
      }
    } catch (e) {
      closeProgress();
      Log.console(e.toString());
    }
    update();
  }
  Future<List<dynamic>> startBooking(String bookingId) async {
    try {
      showProgress();
      var result = await ApiService.startBooking(bookingId);
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        closeProgress();
        getBookingList("");
        bookingDetails(bookingId);
        update();
        return [true, json["msg"].toString()];
      } else {
        closeProgress();
        update();
        return [false, json["msg"].toString()];
      }
    } catch (e) {
      closeProgress();
      Log.console(e.toString());
      update();
      return [false,e.toString()];
    }

  }
  Future<List<dynamic>> startBookingOtp(String bookingId,String otp) async {
    try {
      showProgress();
      var result = await ApiService.startBookingOtp(bookingId,otp);
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        closeProgress();
        getBookingList("");
        bookingDetails(bookingId);
        update();
        return [true, json["msg"].toString()];
      } else {
        closeProgress();
        update();
        return [false, json["msg"].toString()];
      }
    } catch (e) {
      closeProgress();
      update();
      return [false,e.toString()];
    }
    update();
  }
  Future<List<dynamic>> endBooking(String bookingId) async {
    try {
      showProgress();
      var result = await ApiService.endBooking(bookingId);
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        closeProgress();
        getBookingList("");
        bookingDetails(bookingId);
        update();
        return [true, json["message"].toString()];
      } else {
        closeProgress();
        update();
        return [false, json["message"].toString()];
      }
    } catch (e) {
      closeProgress();
      Log.console(e.toString());
      update();
      return [false,e.toString()];
    }

  }
  Future<List<dynamic>> endBookingOtp(String bookingId,String otp) async {
    try {
      showProgress();
      var result = await ApiService.endBookingOtp(bookingId,otp);
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        closeProgress();
        getBookingList("");
        bookingDetails(bookingId);
         update();
        return [true, json["message"].toString()];
      } else {
        closeProgress();
        update();
        return [false, json["message"].toString()];
      }
    } catch (e) {
      closeProgress();
      update();
      return [false,e.toString()];
    }
  }
}
