import 'package:at_your_home_partner/constants/constants.dart';
import 'package:at_your_home_partner/controller/booking_list_controller.dart';
import 'package:at_your_home_partner/controller/user_controller.dart';
import 'package:at_your_home_partner/model/booking_list_model.dart';
import 'package:at_your_home_partner/screens/payment_and_patient_details_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ServiceBookingScreen extends StatefulWidget {
  final String serviceId;
  final String price;
  final String serviceTitle;

  const ServiceBookingScreen({super.key, required this.serviceId, required this.price, required this.serviceTitle});

  @override
  State<ServiceBookingScreen> createState() => _ServiceBookingScreenState();
}

class _ServiceBookingScreenState extends State<ServiceBookingScreen> {
  BookingListController controller = Get.put(BookingListController());
  UserController user = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<BookingListController>(),
      initState: (state) {
        Get.find<BookingListController>().getBookingServiceList(widget.serviceId);
      },
      builder: (contextCtr) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: lightFillCl,
            appBar: AppBar(
              backgroundColor: appBar,
              automaticallyImplyLeading: false,
              leadingWidth: MediaQuery.of(context).size.width,
              leading: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Image.asset(
                        arrowBackIc,
                        height: 24.h,
                        width: 24.w,
                      ),
                    ),
                    SizedBox(width: 13.w),
                    Text(
                      widget.serviceTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: whiteCl,
                        fontStyle: FontStyle.normal,
                        fontSize: 16.sp,
                        fontFamily: semiBold,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
              child: Column(
                children: [
                  Builder(builder: (context) {
                    if (contextCtr.isLoading) {
                      return SizedBox(
                        height: 400,
                        width: 400,
                        child: Center(
                            child: CircularProgressIndicator(
                          color: mainColor,
                        )),
                      );
                    }
                    if (contextCtr.bookingListService.isEmpty) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 200.h,width: MediaQuery.of(context).size.width,),
                          Image.asset(
                            noBooking,
                            height: 175.h,
                            width: 188.w,
                          ),
                          SizedBox(height: 60.h),
                          Text(
                            "Haven't made any bookings yet.",
                            style: TextStyle(
                              color: blackCl,
                              fontStyle: FontStyle.normal,
                              fontSize: 16.sp,
                              fontFamily: semiBold,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      );
                    }
                    return Expanded(
                      child: ListView.builder(
                        itemCount: contextCtr.bookingListService.length,
                        itemBuilder: (BuildContext context, int index) {
                          return itemBookingList(contextCtr.bookingListService[index]);
                        },
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget itemBookingList(BookingData bookingData) {
    return InkWell(
      onTap: () {
        Get.to(() => PaymentAndPatientDetailsScreen(bookingId: bookingData.bookingId.toString()));
      },
      child: Container(
        padding: EdgeInsets.all(9.h),
        margin: EdgeInsets.only(bottom: 20.h),
        decoration: BoxDecoration(
          color: whiteCl,
          borderRadius: BorderRadius.circular(10.dm),
          border: Border.all(color: const Color(0xFFE4E4E4), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 45.h,
                  width: 45.w,
                  padding: EdgeInsets.all(5.w),
                  decoration: BoxDecoration(color: const Color(0xFFEEFFF2), border: Border.all(color: mainColor.withOpacity(0.23), width: 0.5), borderRadius: BorderRadius.circular(5)),
                  child: Image.asset(injectionIc),
                ),
                SizedBox(width: 14.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                          text: TextSpan(
                              text: bookingData.serviceName,
                              style: TextStyle(
                                color: blackCl,
                                fontStyle: FontStyle.normal,
                                fontSize: 16.sp,
                                fontFamily: semiBold,
                                fontWeight: FontWeight.w600,
                              ),
                              children: [
                            TextSpan(
                              text: " (0-5 Kms)",
                              style: TextStyle(
                                color: blackCl,
                                fontStyle: FontStyle.normal,
                                fontSize: 10.sp,
                                fontFamily: semiBold,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ])),
                      SizedBox(height: 10.h),
                      Text(
                        "₹ ${bookingData.totalAmount}",
                        style: TextStyle(
                          color: blackCl,
                          fontStyle: FontStyle.normal,
                          fontSize: 12.sp,
                          fontFamily: semiBold,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 14.w),
                const SizedBox(),
              ],
            ),
            SizedBox(height: 10.h),
            Divider(
              color: borderColorCont,
              height: 1.h,
            ),
            SizedBox(height: 10.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 6.h),
              decoration: BoxDecoration(color: const Color(0xFFECECEC), borderRadius: BorderRadius.circular(7.dm)),
              child: Row(
                children: [
                  Image.asset(homeWorkIc, height: 18.h, width: 18.w),
                  SizedBox(width: 13.w),
                  Expanded(
                    child: Text(
                      bookingData.addressDetails != null ? bookingData.addressDetails!.addressLine1.toString() : "",
                      style: TextStyle(
                        color: blackCl,
                        fontStyle: FontStyle.normal,
                        fontSize: 12.sp,
                        fontFamily: semiBold,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 26.h,
                  width: 26.w,
                  padding: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(color: const Color(0xFFC1E9CA), border: Border.all(color: mainColor.withOpacity(0.23), width: 0.5), borderRadius: BorderRadius.circular(5)),
                  child: Image.asset(dateTimeIc),
                ),
                SizedBox(width: 9.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Booking Date & Time",
                      style: TextStyle(
                        color: hintColor,
                        fontStyle: FontStyle.normal,
                        fontSize: 10.sp,
                        fontFamily: semiBold,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      formatDate(bookingData.deliveryDate.toString()),
                      style: TextStyle(
                        color: blackCl,
                        fontStyle: FontStyle.normal,
                        fontSize: 12.sp,
                        fontFamily: semiBold,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                bookingData.status == "Accept"
                    ? Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                        decoration: BoxDecoration(
                          color: blueLightCl,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: blueLightCl, width: 0.5),
                        ),
                        child: Row(
                          children: [
                            Image.asset(outlineDirectionsIc, height: 16.h, width: 16.w),
                            SizedBox(width: 6.w),
                            Text(
                              "Get directions",
                              style: TextStyle(
                                color: whiteCl,
                                fontStyle: FontStyle.normal,
                                fontSize: 12.sp,
                                fontFamily: semiBold,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 4.h),
                        decoration: BoxDecoration(
                            color: bookingData.status == "requested"
                                ? pendingCl
                                : bookingData.status == "cancelled"
                                    ? cancelCl
                                    : doneCl,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                                color: bookingData.status == "requested"
                                    ? pendingBorderCl
                                    : bookingData.status == "cancelled"
                                        ? cancelBorderCl
                                        : doneBorderCl,
                                width: 0.5)),
                        child: Row(
                          children: [
                            Image.asset(
                                bookingData.status == "requested"
                                    ? clockTime
                                    : bookingData.status == "cancelled"
                                        ? outlineCancel
                                        : ggCheck,
                                height: 16.h,
                                width: 16.w),
                            SizedBox(width: 3.w),
                            Text(
                              bookingData.status.toString().capitalizeFirst!,
                              style: TextStyle(
                                color: bookingData.status == "requested"
                                    ? pendingBorderCl
                                    : bookingData.status == "cancelled"
                                        ? cancelBorderCl
                                        : doneBorderCl,
                                fontStyle: FontStyle.normal,
                                fontSize: 12.sp,
                                fontFamily: semiBold,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
              ],
            )
          ],
        ),
      ),
    );
  }

  String formatDate(String date) {
    try {
      var parsedDate = DateFormat("dd-MM-yyyy").parse(date);
      var formattedDate = DateFormat("dd-MM-yyyy").format(parsedDate);
      return formattedDate;
    } catch (e) {
      return "N/A";
    }
  }
}
