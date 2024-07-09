import 'package:at_your_home_partner/constants/constants.dart';
import 'package:at_your_home_partner/controller/booking_list_controller.dart';
import 'package:at_your_home_partner/core/common_widgets/custom_buttons.dart';
import 'package:at_your_home_partner/core/expandable_text_widget.dart';
import 'package:at_your_home_partner/screens/prescription_screen.dart';
import 'package:at_your_home_partner/screens/successfully_completed_screen.dart';
import 'package:at_your_home_partner/service/api_url.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentAndPatientDetailsScreen extends StatefulWidget {
  final String bookingId;

  const PaymentAndPatientDetailsScreen({super.key, required this.bookingId});

  @override
  State<PaymentAndPatientDetailsScreen> createState() => _PaymentAndPatientDetailsScreenState();
}

class _PaymentAndPatientDetailsScreenState extends State<PaymentAndPatientDetailsScreen> {
  BookingListController controller = Get.put(BookingListController());
  String otp = "";

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<BookingListController>(),
      initState: (state) {
        Get.find<BookingListController>().bookingDetails(widget.bookingId);
      },
      builder: (contextCtr) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: whiteCl,
            appBar: AppBar(
              backgroundColor: appBar,
              automaticallyImplyLeading: false,
              leadingWidth: MediaQuery.of(context).size.width,
              leading: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Image.asset(
                        arrowBackIc,
                        height: 26.h,
                        width: 26.w,
                      ),
                    ),
                    SizedBox(width: 13.w),
                    Text(
                      "Details",
                      style: TextStyle(
                        color: whiteCl,
                        fontStyle: FontStyle.normal,
                        fontSize: 18.sp,
                        fontFamily: semiBold,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () async {
                        var url = "tel:91${contextCtr.bookingDetailsModel.value.userDetails!.mobile}";
                        if (await launchUrl(Uri.parse(url))) {
                          await launchUrl(Uri.parse(url));
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      child: Image.asset(
                        callIc,
                        height: 26.h,
                        width: 26.w,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: SingleChildScrollView(
                child: Builder(builder: (context) {
                  if (contextCtr.isLoading) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height - 200,
                      width: MediaQuery.of(context).size.width,
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: mainColor,
                        ),
                      ),
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 14.h, width: MediaQuery.of(context).size.width),
                      Container(
                        decoration: BoxDecoration(color: const Color(0xFFF3F3F3), borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFFE4E4E4))),
                        padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 8.h),
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
                                      contextCtr.bookingDetailsModel.value.deliveryDate.toString(),
                                      style: TextStyle(
                                        color: const Color(0xFF454545),
                                        fontStyle: FontStyle.normal,
                                        fontSize: 12.sp,
                                        fontFamily: regular,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      ", ${contextCtr.bookingDetailsModel.value.deliveryTime}",
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
                          ],
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        "Patient Details",
                        style: TextStyle(
                          color: blackCl,
                          fontStyle: FontStyle.normal,
                          fontSize: 14.sp,
                          fontFamily: semiBold,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Row(
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
                              userNewIc,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Patient Name",
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
                                "${contextCtr.bookingDetailsModel.value.patientDetails?.name}",
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
                      SizedBox(height: 12.h),
                      Divider(
                        color: borderColorCont,
                        height: 1.h,
                      ),
                      SizedBox(height: 12.h),
                      Row(
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
                              genderNewIc,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Age & Gander",
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
                                "${contextCtr.bookingDetailsModel.value.patientDetails?.age}, ${contextCtr.bookingDetailsModel.value.patientDetails?.gender} ",
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
                      SizedBox(height: 12.h),
                      Divider(
                        color: borderColorCont,
                        height: 1.h,
                      ),
                      SizedBox(height: 12.h),
                      Row(
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
                                "${contextCtr.bookingDetailsModel.value.addressDetails?.addressLine1} ",
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
                      SizedBox(height: 12.h),
                      Row(
                        children: [
                          const Spacer(),
                          contextCtr.bookingDetailsModel.value.status == "pending"
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
                                      color: contextCtr.bookingDetailsModel.value.status == "requested"
                                          ? pendingCl
                                          : contextCtr.bookingDetailsModel.value.status == "cancelled"
                                              ? cancelCl
                                              : doneCl,
                                      borderRadius: BorderRadius.circular(14),
                                      border: Border.all(
                                          color: contextCtr.bookingDetailsModel.value.status == "requested"
                                              ? pendingBorderCl
                                              : contextCtr.bookingDetailsModel.value.status == "cancelled"
                                                  ? cancelBorderCl
                                                  : doneBorderCl,
                                          width: 0.5)),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                          contextCtr.bookingDetailsModel.value.status == "requested"
                                              ? clockTime
                                              : contextCtr.bookingDetailsModel.value.status == "cancelled"
                                                  ? outlineCancel
                                                  : ggCheck,
                                          height: 12.h,
                                          width: 12.w),
                                      SizedBox(width: 3.w),
                                      Text(
                                        contextCtr.bookingDetailsModel.value.status.toString().capitalizeFirst!,
                                        style: TextStyle(
                                          color: contextCtr.bookingDetailsModel.value.status == "requested"
                                              ? pendingBorderCl
                                              : contextCtr.bookingDetailsModel.value.status == "cancelled"
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
                          SizedBox(width: 30.w),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      Divider(
                        color: borderColorCont,
                        height: 1.h,
                      ),
                      SizedBox(height: 16.h),
                      contextCtr.bookingDetailsModel.value.patientDetails!.prescriptionImage!.isEmpty
                          ? const SizedBox()
                          : SizedBox(
                              height: 111,
                              width: MediaQuery.of(context).size.width,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: ListView.builder(
                                  clipBehavior: Clip.none,
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: contextCtr.bookingDetailsModel.value.patientDetails!.prescriptionImage?.length,
                                  reverse: true,
                                  itemBuilder: (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Get.to(() => PrescriptionScreen(imageUrl: ApiUrl.imageUrl + contextCtr.bookingDetailsModel.value.patientDetails!.prescriptionImage![index].image.toString()));
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(right: 9),
                                        height: 111,
                                        width: 111,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: mainColor, width: 1),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: contextCtr.bookingDetailsModel.value.patientDetails!.prescriptionImage![index].image != ""
                                              ? CachedNetworkImage(
                                                  errorWidget: (context, url, error) => Image.asset(
                                                    clientDemo,
                                                    fit: BoxFit.fill,
                                                    height: 90.h,
                                                    width: 70.w,
                                                  ),
                                                  fit: BoxFit.fill,
                                                  height: 90.h,
                                                  width: 70.w,
                                                  imageUrl: ApiUrl.imageUrl + contextCtr.bookingDetailsModel.value.patientDetails!.prescriptionImage![index].image.toString(),
                                                  placeholder: (a, b) => const Center(
                                                    child: CircularProgressIndicator(),
                                                  ),
                                                )
                                              : Image.asset(slipImg, fit: BoxFit.cover),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                      SizedBox(height: 16.h),
                      Text(
                        "Service Details",
                        style: TextStyle(
                          color: blackCl,
                          fontStyle: FontStyle.normal,
                          fontSize: 14.sp,
                          fontFamily: semiBold,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        padding: EdgeInsets.all(6.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF6FFF8),
                          borderRadius: BorderRadius.circular(8.dm),
                          border: Border.all(color: const Color(0xFF30783F), width: 0.5),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 64.h,
                                  width: 64.w,
                                  padding: EdgeInsets.all(5.w),
                                  decoration: BoxDecoration(color: const Color(0xFFE1FFE8), border: Border.all(color: mainColor.withOpacity(0.23), width: 0.5), borderRadius: BorderRadius.circular(5)),
                                  child: contextCtr.bookingDetailsModel.value.serviceBannerImage != ""
                                      ? CachedNetworkImage(
                                          errorWidget: (context, url, error) => Image.asset(drDemoImg, fit: BoxFit.fill, height: 82.h, width: 82.w),
                                          fit: BoxFit.fill,
                                          height: 82.h,
                                          width: 82.w,
                                          imageUrl: ApiUrl.imageUrl + contextCtr.bookingDetailsModel.value.serviceBannerImage.toString(),
                                          placeholder: (a, b) => const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        )
                                      : Image.asset(injectionIc),
                                ),
                                SizedBox(width: 14.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        contextCtr.bookingDetailsModel.value.serviceName.toString(),
                                        style: TextStyle(
                                          color: blackCl,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 16.sp,
                                          fontFamily: semiBold,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height: 15.h),
                                      Text(
                                        "₹ ${contextCtr.bookingDetailsModel.value.servicePrice}",
                                        style: TextStyle(
                                          color: blackCl,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 16.sp,
                                          fontFamily: semiBold,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 9.h),
                            /* Html(
                                data:contextCtr.bookingDetailsModel.value.serviceSubDescription.toString(),
                                shrinkWrap: true,
                                style: {
                                  "body": Style(
                                    fontSize: FontSize(10.0),
                                    fontWeight: FontWeight.w600,
                                    fontFamily: regular,
                                    color: Colors.black,
                                  ),
                                },
                              )*/
                            ExpandableTextWidget(text: contextCtr.bookingDetailsModel.value.serviceSubDescription.toString())
                          ],
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        "Payment Details",
                        style: TextStyle(
                          color: blackCl,
                          fontStyle: FontStyle.normal,
                          fontSize: 14.sp,
                          fontFamily: semiBold,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Container(
                        padding: EdgeInsets.all(6.h),
                        decoration: BoxDecoration(
                          color: whiteCl,
                          borderRadius: BorderRadius.circular(8.dm),
                          border: Border.all(color: const Color(0xFFE4E4E4), width: 1),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 40.h,
                              width: 40.w,
                              padding: EdgeInsets.all(4.w),
                              decoration: BoxDecoration(color: mainColor, border: Border.all(color: mainColor.withOpacity(0.23), width: 0.5), borderRadius: BorderRadius.circular(5)),
                              child: Image.asset(
                                money,
                                color: whiteCl,
                              ),
                            ),
                            SizedBox(width: 9.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    contextCtr.bookingDetailsModel.value.paymentType.toString(),
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 12.sp,
                                      fontFamily: semiBold,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(height: 2.h),
                                  Text(
                                    "₹ ${contextCtr.bookingDetailsModel.value.totalAmount}",
                                    style: TextStyle(
                                      color: blackCl,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.sp,
                                      fontFamily: semiBold,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                              decoration: BoxDecoration(color: doneCl, borderRadius: BorderRadius.circular(14), border: Border.all(color: doneBorderCl, width: 0.5)),
                              child: Row(
                                children: [
                                  Image.asset(ggCheck, height: 16.h, width: 16.w),
                                  SizedBox(width: 3.w),
                                  Text(
                                    "Received",
                                    style: TextStyle(
                                      color: doneBorderCl,
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
                        ),
                      ),
                      SizedBox(height: 80.h),
                    ],
                  );
                }),
              ),
            ),
            bottomSheet: contextCtr.isLoading
                ? const SizedBox()
                : Container(
                    color: whiteCl,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: contextCtr.bookingDetailsModel.value.status == "requested" ? 20.w : 60.w, vertical: 15.h),
                    child: Wrap(
                      children: [
                        contextCtr.bookingDetailsModel.value.status == "requested"
                            ? Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        contextCtr.vendorCancelledBooking(contextCtr.bookingDetailsModel.value.bookingId.toString());
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
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
                                        contextCtr.vendorBookingAccept(contextCtr.bookingDetailsModel.value.bookingId.toString(), "1");
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
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
                            : contextCtr.bookingDetailsModel.value.status == "cancelled"
                                ? CustomButtonWidget(
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                    style: CustomButtonStyle.style2,
                                    onPressed: () {},
                                    text: contextCtr.bookingDetailsModel.value.status.toString().capitalizeFirst.toString(),
                                  )
                                : contextCtr.bookingDetailsModel.value.status == "pending"
                                    ? CustomButtonWidget(
                                        padding: const EdgeInsets.symmetric(vertical: 12),
                                        style: CustomButtonStyle.style2,
                                        onPressed: () async {
                                          otp = "";
                                          otpDialogShow("start", contextCtr.bookingDetailsModel.value.bookingId.toString());
                                        },
                                        text: 'Booking Start',
                                      )
                                    : contextCtr.bookingDetailsModel.value.status == "started"
                                        ? CustomButtonWidget(
                                            padding: const EdgeInsets.symmetric(vertical: 12),
                                            style: CustomButtonStyle.style2,
                                            onPressed: () async {
                                              otp = "";
                                              otpDialogShow("end", contextCtr.bookingDetailsModel.value.bookingId.toString());
                                            },
                                            text: 'Booking End',
                                          )
                                        : CustomButtonWidget(
                                            padding: const EdgeInsets.symmetric(vertical: 12),
                                            style: CustomButtonStyle.style2,
                                            onPressed: () {},
                                            text: contextCtr.bookingDetailsModel.value.status.toString().capitalizeFirst.toString(),
                                          )
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }

  void otpDialogShow(String type, String booKingId) {
    showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          elevation: 0,
          insetPadding: const EdgeInsets.symmetric(horizontal: 16),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(14),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 36),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: whiteCl, borderRadius: BorderRadius.circular(14), border: Border.all(color: blackCl, width: 2)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "OTP ",
                      style: TextStyle(
                        color: Colors.black,
                        fontStyle: FontStyle.normal,
                        fontSize: 20.sp,
                        fontFamily: semiBold,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: RichText(
                          text: TextSpan(
                              text: "Please enter the verification code sent to customer booking details ",
                              style: TextStyle(
                                color: greyColorTxt,
                                fontStyle: FontStyle.normal,
                                fontSize: 14.sp,
                                fontFamily: regular,
                                fontWeight: FontWeight.w400,
                              ),
                              children: const [
                                /*TextSpan(
                                  text: "+91 8974784141",
                                  style: TextStyle(
                                    color: blackCl,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 14.sp,
                                    fontFamily: semiBold,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )*/
                              ]),
                        )),
                    SizedBox(height: 46.h),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      height: 48,
                      child: PinCodeTextField(
                        cursorColor: mainColor,
                        keyboardType: TextInputType.number,
                        obscureText: false,
                        obscuringCharacter: "*",
                        textStyle: const TextStyle(
                          color: mainColor,
                          fontSize: 14,
                          fontFamily: regular,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                        ),
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(16.dm),
                          fieldHeight: 48.h,
                          fieldWidth: 50.w,
                          disabledColor: borderColorCont,
                          fieldOuterPadding: const EdgeInsets.symmetric(horizontal: 6),
                          selectedFillColor: lightFillCl,
                          inactiveFillColor: lightFillCl,
                          activeFillColor: lightFillCl,
                          activeColor: mainColor,
                          inactiveColor: borderColorCont,
                          errorBorderColor: borderColorCont,
                          selectedColor: mainColor,
                          activeBorderWidth: 1,
                          selectedBorderWidth: 1,
                          disabledBorderWidth: 1,
                          inactiveBorderWidth: 1,
                          errorBorderWidth: 1,
                          borderWidth: 1,
                        ),
                        appContext: context,
                        length: 4,
                        onChanged: (String value) {
                          otp = value;
                        },
                      ),
                    ),
                    SizedBox(height: 70.h),
                    SizedBox(
                      height: 44,
                      child: CustomButtonWidget(
                        padding: EdgeInsets.zero,
                        style: CustomButtonStyle.style2,
                        onPressed: () async {
                          if (type == "start") {
                            var result = await controller.startBookingOtp(booKingId, otp);
                            if (result.isNotEmpty && result[0] == true) {
                              otp = "";
                              Get.back();
                              successToast(result[1].toString());
                            } else {
                              Get.back();
                              errorToast(result.isNotEmpty ? result[1] : "Something went wrong");
                            }
                          } else {
                            var result = await controller.endBookingOtp(booKingId, otp);
                            if (result.isNotEmpty && result[0] == true) {
                              otp = "";
                              Get.to(() => const SuccessfullyCompleted());
                              successToast(result[1].toString());
                            } else {
                              Get.back();
                              errorToast(result.isNotEmpty ? result[1] : "Something went wrong");
                            }
                          }
                        },
                        text: 'Submit',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
