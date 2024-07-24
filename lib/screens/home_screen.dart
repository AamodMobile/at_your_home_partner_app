import 'package:at_your_home_partner/constants/constants.dart';
import 'package:at_your_home_partner/controller/booking_list_controller.dart';
import 'package:at_your_home_partner/controller/user_controller.dart';
import 'package:at_your_home_partner/core/common_widgets/custom_buttons.dart';
import 'package:at_your_home_partner/model/booking_list_model.dart';
import 'package:at_your_home_partner/screens/create_service_screen.dart';
import 'package:at_your_home_partner/screens/drawer_screen.dart';
import 'package:at_your_home_partner/screens/notification_screen.dart';
import 'package:at_your_home_partner/screens/payment_and_patient_details_screen.dart';
import 'package:at_your_home_partner/service/api_url.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
    "Requested",
    "Accepted",
    "Started",
    "Completed",
    "Cancelled",
  ];

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  BookingListController controller = Get.put(BookingListController());
  UserController user = Get.put(UserController());

  @override
  void initState() {
    checkAvailability();
    /* WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getDialogAlert();
    });*/
    controller.selectedIndex = 0;
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
        Get.find<BookingListController>().getBookingList("").then((v) {
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
                                    ? contextCtrl.acceptedList.isEmpty
                                    : (contextCtrl.selectedIndex == 3)
                                        ? contextCtrl.startedList.isEmpty
                                        : (contextCtrl.selectedIndex == 4)
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
                            child: RefreshIndicator(
                              onRefresh: () {
                                return Future.delayed(const Duration(seconds: 1), () {
                                  contextCtrl.getBookingList("");
                                });
                              },
                              child: Builder(builder: (context) {
                                if (contextCtrl.isLoading) {
                                  return const SizedBox(
                                    height: 400,
                                    width: 400,
                                    child: Center(
                                        child: CircularProgressIndicator(
                                      color: mainColor,
                                    )),
                                  );
                                }
                                List currentList;
                                switch (contextCtrl.selectedIndex) {
                                  case 0:
                                    currentList = contextCtrl.bookingList;
                                    break;
                                  case 1:
                                    currentList = contextCtrl.pendingList;
                                    break;
                                  case 2:
                                    currentList = contextCtrl.acceptedList;
                                    break;
                                  case 3:
                                    currentList = contextCtrl.startedList;
                                    break;
                                  case 4:
                                    currentList = contextCtrl.completedList;
                                    break;
                                  case 5:
                                    currentList = contextCtrl.cancelledList;
                                    break;
                                  default:
                                    currentList = [];
                                }
                                if (currentList.isEmpty) {
                                  return const Center(
                                    child: Text('No items available'),
                                  );
                                }

                                return ListView.builder(
                                  itemCount: currentList.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return itemBookingList(currentList[index]);
                                  },
                                );

                                /*  return ListView.builder(
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
                                );*/
                              }),
                            ),
                          ),
                SizedBox(height: 70.h),
              ],
            ),
            bottomSheet: Container(
              color: lightFillCl,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 60.w, vertical: 15.h),
              child: Wrap(
                children: [
                  SizedBox(
                    height: 43.h,
                    child: CustomButtonWidget(
                      padding: EdgeInsets.zero,
                      style: CustomButtonStyle.style2,
                      onPressed: () {
                        Get.to(() => const CreateServiceScreen());
                      },
                      text: 'Create Service',
                    ),
                  ),
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
        margin: EdgeInsets.only(bottom: 9.h, right: 16.w, left: 16.w),
        decoration: BoxDecoration(
            color: whiteCl,
            borderRadius: BorderRadius.circular(10.dm),
            border: Border.all(color: const Color(0xFF6AAE74), width: 1),
            gradient: const LinearGradient(colors: [
              Color(0xFFF6FFF8),
              Color(0xFFFFFFFF),
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 9.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 9.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 30.h,
                    width: 30.w,
                    padding: EdgeInsets.all(7.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE5F9E9),
                      border: Border.all(color: mainColor.withOpacity(0.23), width: 0.5),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Image.asset(
                      timeNewIc,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Booking Date & Time",
                        style: TextStyle(
                          color: const Color(0xFF002C07),
                          fontStyle: FontStyle.normal,
                          fontSize: 12.sp,
                          fontFamily: semiBold,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Row(
                        children: [
                          Text(
                            bookingData.deliveryDate.toString(),
                            style: TextStyle(
                              color: const Color(0xFF454545),
                              fontStyle: FontStyle.normal,
                              fontSize: 12.sp,
                              fontFamily: regular,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            ", ${bookingData.deliveryTime}",
                            style: TextStyle(
                              color: const Color(0xFF454545),
                              fontStyle: FontStyle.normal,
                              fontSize: 12.sp,
                              fontFamily: regular,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
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
                                  fontSize: 10.sp,
                                  fontFamily: regular,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(
                          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 5.h),
                          decoration: BoxDecoration(
                              color: bookingData.status == "requested"
                                  ? pendingCl
                                  : bookingData.status == "cancelled"
                                      ? cancelCl
                                      : doneCl,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                  color: bookingData.status == "requested"
                                      ? pendingBorderCl
                                      : bookingData.status == "cancelled"
                                          ? cancelBorderCl
                                          : doneBorderCl,
                                  width: 0.5)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                  bookingData.status == "requested"
                                      ? clockTime
                                      : bookingData.status == "cancelled"
                                          ? outlineCancel
                                          : ggCheck,
                                  height: 12.h,
                                  width: 12.w),
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
                                  fontSize: 10.sp,
                                  fontFamily: regular,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            ),
            SizedBox(height: 12.h),
            Divider(
              color: borderColorCont,
              height: 1.h,
            ),
            SizedBox(height: 12.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 9.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 30.h,
                    width: 30.w,
                    padding: EdgeInsets.all(7.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE5F9E9),
                      border: Border.all(color: mainColor.withOpacity(0.23), width: 0.5),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Image.asset(
                      locationNewIc,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Address",
                        style: TextStyle(
                          color: const Color(0xFF002C07),
                          fontStyle: FontStyle.normal,
                          fontSize: 12.sp,
                          fontFamily: semiBold,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        bookingData.addressDetails != null ? bookingData.addressDetails!.addressLine1.toString() : "",
                        style: TextStyle(
                          color: const Color(0xFF454545),
                          fontStyle: FontStyle.normal,
                          fontSize: 12.sp,
                          fontFamily: regular,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.h),
            Divider(
              color: borderColorCont,
              height: 1.h,
            ),
            SizedBox(height: 6.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 9.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 36.h,
                    width: 36.w,
                    padding: EdgeInsets.all(5.w),
                    decoration: BoxDecoration(color: whiteCl, border: Border.all(color: mainColor.withOpacity(0.23), width: 0.5), borderRadius: BorderRadius.circular(5)),
                    child: bookingData.serviceDetails != null && bookingData.serviceDetails!.bannerImage != ""
                        ? CachedNetworkImage(
                            errorWidget: (context, url, error) => Image.asset(drDemoImg, fit: BoxFit.fill, height: 82.h, width: 82.w),
                            fit: BoxFit.fill,
                            height: 82.h,
                            width: 82.w,
                            imageUrl: ApiUrl.imageUrl + bookingData.serviceDetails!.bannerImage.toString(),
                            placeholder: (a, b) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : Image.asset(injectionIc),
                  ),
                  SizedBox(width: 7.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        bookingData.bookingDetails != null ? "${bookingData.bookingDetails!.length} service add" : "",
                        style: TextStyle(
                          color: const Color(0xFF002C07),
                          fontStyle: FontStyle.normal,
                          fontSize: 12.sp,
                          fontFamily: semiBold,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        "₹ ${bookingData.totalAmount}",
                        style: TextStyle(
                          color: const Color(0xFF454545),
                          fontStyle: FontStyle.normal,
                          fontSize: 12.sp,
                          fontFamily: regular,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Image.asset(
                    arrowRightNew,
                    height: 24.h,
                    width: 24.w,
                  )
                ],
              ),
            ),
            SizedBox(height: 9.h),
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
                                  "Yashmak Nagar 1st Block 1st Cross, Murthy nagar, Bangalore-560016",
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
