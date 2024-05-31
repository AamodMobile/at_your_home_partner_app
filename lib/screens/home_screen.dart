import 'package:at_your_home_partner/constants/constants.dart';
import 'package:at_your_home_partner/controller/booking_list_controller.dart';
import 'package:at_your_home_partner/controller/user_controller.dart';
import 'package:at_your_home_partner/model/booking_list_model.dart';
import 'package:at_your_home_partner/screens/drawer_screen.dart';
import 'package:at_your_home_partner/screens/notification_screen.dart';
import 'package:at_your_home_partner/screens/payment_and_patient_details_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List type = [
    "All Booking",
    "Pending",
    "Completed",
    "Cancelled",
  ];

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  BookingListController controller = Get.put(BookingListController());
  UserController user = Get.put(UserController());

  @override
  void initState() {
    checkAvailability();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getDialogAlert();
    });

    super.initState();
  }

  void checkAvailability() async {
    var pref = await SharedPreferences.getInstance();
    var isAvailability = pref.getString('isAvailability');
    controller.isAvailabilityStatus.value = isAvailability.toString();
    await pref.reload();
  }

  void getDialogAlert() async {
    alertDialog1();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<BookingListController>(),
      initState: (state) {
        Get.find<BookingListController>().getBookingList().then((v) {
          user.vendorGetProfile();
        });
      },
      builder: (contextCtrl) {
        return SafeArea(
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: whiteCl,
            drawer: const DrawerScreen(),
            appBar: AppBar(
              backgroundColor: appBar,
              automaticallyImplyLeading: false,
              leadingWidth: MediaQuery.of(context).size.width,
              leading: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (scaffoldKey.currentState!.isDrawerOpen) {
                          scaffoldKey.currentState!.openEndDrawer();
                        } else {
                          scaffoldKey.currentState!.openDrawer();
                        }
                      },
                      child: Image.asset(
                        menuRoundIc,
                        height: 26.h,
                        width: 26.w,
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const NotificationScreen());
                          },
                          child: Image.asset(
                            bellIc,
                            height: 26.h,
                            width: 26.w,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        GestureDetector(
                          onTap: () {
                            contextCtrl.vendorOnOff().then((v) {
                              setState(() {});
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: whiteCl,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: controller.isAvailabilityStatus.value == "1" ? const Color(0xFFD0C800) : redColor, width: 1),
                            ),
                            child: controller.isAvailabilityStatus.value == "1"
                                ? Row(
                                    children: [
                                      Container(
                                        height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(shape: BoxShape.circle, color: whiteCl, border: Border.all(color: const Color(0xFFD0C800), width: 5)),
                                      ),
                                      const SizedBox(
                                        width: 2,
                                      ),
                                      Text(
                                        "ON",
                                        style: TextStyle(
                                          color: const Color(0xFFD0C800),
                                          fontStyle: FontStyle.normal,
                                          fontSize: 14.sp,
                                          fontFamily: semiBold,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(width: 3),
                                    ],
                                  )
                                : Row(
                                    children: [
                                      const SizedBox(width: 3),
                                      Text(
                                        "OFF",
                                        style: TextStyle(
                                          color: redColor,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 14.sp,
                                          fontFamily: semiBold,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 2,
                                      ),
                                      Container(
                                        height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(shape: BoxShape.circle, color: whiteCl, border: Border.all(color: redColor, width: 5)),
                                      ),
                                    ],
                                  ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            body: Column(
              children: [
                Container(
                  height: 35.h,
                  padding: EdgeInsets.only(top: 8.h, right: 15.w, left: 15.w),
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(color: whiteCl),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: type.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  contextCtrl.selectedIndex = index;
                                });
                              },
                              child: Column(
                                children: [
                                  Text(
                                    type[index],
                                    style: TextStyle(
                                      color: contextCtrl.selectedIndex == index ? mainColor : const Color(0xFF807E7E),
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.sp,
                                      fontFamily: regular,
                                      fontWeight: contextCtrl.selectedIndex == index ? FontWeight.w600 : FontWeight.w400,
                                    ),
                                  ),
                                  contextCtrl.selectedIndex == index
                                      ? Container(
                                          width: 65.w,
                                          height: 2,
                                          color: mainColor,
                                        )
                                      : SizedBox(width: 65.w)
                                ],
                              ),
                            ),
                            SizedBox(width: 22.w),
                          ],
                        );
                      }),
                ),
                SizedBox(height: 10.h),
                contextCtrl.isLoading
                    ? const SizedBox(
                        height: 400,
                        width: 400,
                        child: Center(
                            child: CircularProgressIndicator(
                          color: mainColor,
                        )),
                      )
                    : ((contextCtrl.selectedIndex == 0)
                            ? contextCtrl.bookingList.isEmpty
                            : (contextCtrl.selectedIndex == 1)
                                ? contextCtrl.pendingList.isEmpty
                                : (contextCtrl.selectedIndex == 2)
                                    ? contextCtrl.completedList.isEmpty
                                    : contextCtrl.cancelledList.isEmpty)
                        ? Column(
                            children: [
                              SizedBox(height: 85.h),
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
                              SizedBox(height: 60.h),
                              SizedBox(height: 40.h),
                            ],
                          )
                        : Expanded(
                            child: ListView.builder(
                              itemCount: (contextCtrl.selectedIndex == 0)
                                  ? contextCtrl.bookingList.length
                                  : (contextCtrl.selectedIndex == 1)
                                      ? contextCtrl.pendingList.length
                                      : (contextCtrl.selectedIndex == 2)
                                          ? contextCtrl.completedList.length
                                          : contextCtrl.cancelledList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return itemBookingList((contextCtrl.selectedIndex == 0)
                                    ? contextCtrl.bookingList[index]
                                    : (contextCtrl.selectedIndex == 1)
                                        ? contextCtrl.pendingList[index]
                                        : (contextCtrl.selectedIndex == 2)
                                            ? contextCtrl.completedList[index]
                                            : contextCtrl.cancelledList[index]);
                              },
                            ),
                          ),
              ],
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
        margin: EdgeInsets.only(bottom: 9.h, right: 16.w, left: 16.w),
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
                        bookingData.addressDetails!=null?
                      bookingData.addressDetails!.addressLine1.toString():"",
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

  void alertDialog1() {
    showDialog(
      context: context,
      builder: (_) {
        return const Dialog(
            elevation: 0,
            insetPadding: EdgeInsets.symmetric(horizontal: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: AlertDialog());
      },
    );
  }
}

class AlertDialog extends StatelessWidget {
  const AlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: const Color(0xFF9EBA9B),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          height: 30,
                          width: 30,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Image.asset(
                            cancelIc,
                            height: 30,
                            width: 30,
                            color: whiteCl,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset(
                      redLightGif,
                      height: 100,
                      width: 100,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: whiteCl,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "New Order",
                          style: TextStyle(
                            color: cancelBorderCl,
                            fontStyle: FontStyle.normal,
                            fontSize: 16.sp,
                            fontFamily: semiBold,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 22.h,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 60),
                          decoration: const BoxDecoration(color: lightFillCl),
                          child: Text(
                            "Injection IM",
                            style: TextStyle(
                              color: blackCl,
                              fontStyle: FontStyle.normal,
                              fontSize: 18.sp,
                              fontFamily: semiBold,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 22.h,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
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
                                  "12-04-2024, 10:AM to 11: AM",
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
                          ],
                        ),
                        SizedBox(
                          height: 22.h,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                          decoration: BoxDecoration(color: const Color(0xFFECECEC), borderRadius: BorderRadius.circular(7.dm)),
                          child: Row(
                            children: [
                              Image.asset(locationIc, height: 18.h, width: 18.w),
                              SizedBox(width: 13.w),
                              Expanded(
                                child: Text(
                                  "Akshya Nagar 1st Block 1st Cross, Rammurthy nagar, Bangalore-560016",
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
                        SizedBox(
                          height: 80.h,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 10.h),
                                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: cancelBorderCl)),
                                  child: Center(
                                    child: Text(
                                      "Reject",
                                      style: TextStyle(
                                        color: cancelBorderCl,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 16.sp,
                                        fontFamily: semiBold,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 10.h),
                                  decoration: BoxDecoration(color: appBar, borderRadius: BorderRadius.circular(10), border: Border.all(color: appBar)),
                                  child: Center(
                                    child: Text(
                                      "Accept",
                                      style: TextStyle(
                                        color: whiteCl,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 16.sp,
                                        fontFamily: semiBold,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
