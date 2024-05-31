import 'package:at_your_home_partner/constants/constants.dart';
import 'package:at_your_home_partner/controller/booking_list_controller.dart';
import 'package:at_your_home_partner/core/common_widgets/custom_buttons.dart';
import 'package:at_your_home_partner/core/expandable_text_widget.dart';
import 'package:at_your_home_partner/screens/prescription_screen.dart';
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
                        SizedBox(height: 10.h),
                        SizedBox(
                          height: 111,
                          width: MediaQuery.of(context).size.width,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: ListView.builder(
                              clipBehavior: Clip.none,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: 1,
                              reverse: true,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(() => PrescriptionScreen(imageUrl: ApiUrl.imageUrl + contextCtr.bookingDetailsModel.value.prescription.toString()));
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
                                      child: contextCtr.bookingDetailsModel.value.prescription != ""
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
                                              imageUrl: ApiUrl.imageUrl + contextCtr.bookingDetailsModel.value.prescription.toString(),
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
                        SizedBox(height: 14.h),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(color: bgGryCl, border: Border.all(color: borderColorCont, width: 1), borderRadius: BorderRadius.circular(10.dm)),
                          child: Column(
                            children: [
                              SizedBox(height: 8.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          userOutlineIc,
                                          height: 16.h,
                                          width: 16.w,
                                          fit: BoxFit.cover,
                                        ),
                                        SizedBox(width: 10.w),
                                        Text(
                                          "Patient Name",
                                          style: TextStyle(
                                            color: mainColor,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 12.sp,
                                            fontFamily: semiBold,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      contextCtr.bookingDetailsModel.value.userName.toString(),
                                      style: TextStyle(
                                        color: blackCl,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 14.sp,
                                        fontFamily: semiBold,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5.h),
                              Divider(color: borderColorCont, height: 1.h),
                              SizedBox(height: 5.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          dateRangeIc,
                                          height: 16.h,
                                          width: 16.w,
                                          fit: BoxFit.cover,
                                        ),
                                        SizedBox(width: 10.w),
                                        Text(
                                          "Age",
                                          style: TextStyle(
                                            color: mainColor,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 12.sp,
                                            fontFamily: semiBold,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "${contextCtr.bookingDetailsModel.value.age.toString()} Years",
                                      style: TextStyle(
                                        color: blackCl,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 14.sp,
                                        fontFamily: semiBold,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5.h),
                              Divider(color: borderColorCont, height: 1.h),
                              SizedBox(height: 5.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          maleIc,
                                          height: 16.h,
                                          width: 16.w,
                                          color: mainColor,
                                          fit: BoxFit.cover,
                                        ),
                                        SizedBox(width: 10.w),
                                        Text(
                                          "Gender",
                                          style: TextStyle(
                                            color: mainColor,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 12.sp,
                                            fontFamily: semiBold,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      contextCtr.bookingDetailsModel.value.gender!.capitalizeFirst.toString(),
                                      style: TextStyle(
                                        color: blackCl,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 14.sp,
                                        fontFamily: semiBold,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 8.h),
                            ],
                          ),
                        ),
                        SizedBox(height: 15.h),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 11.h),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF4FEF3),
                            border: Border.all(color: mainColor, width: 2),
                            borderRadius: BorderRadius.circular(10.dm),
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
                                  dateTimeIc,
                                  color: whiteCl,
                                ),
                              ),
                              SizedBox(width: 9.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Booking Date & Time",
                                    style: TextStyle(
                                      color: blackCl,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 10.sp,
                                      fontFamily: semiBold,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(height: 2.h),
                                  Text(
                                    "${contextCtr.bookingDetailsModel.value.deliveryDate!.toString()}, ${contextCtr.bookingDetailsModel.value.deliveryTime!.toString()}",
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
                            ],
                          ),
                        ),
                        SizedBox(height: 15.h),
                        Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFE3DD),
                              border: Border.all(color: const Color(0xFFCE9E94), width: 1),
                              borderRadius: BorderRadius.circular(10.dm),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      locationIc,
                                      height: 16.h,
                                      width: 16.w,
                                      color: const Color(0xFFA41C00),
                                      fit: BoxFit.cover,
                                    ),
                                    SizedBox(width: 10.w),
                                    Text(
                                      "Address",
                                      style: TextStyle(
                                        color: blackCl,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 14.sp,
                                        fontFamily: semiBold,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 7.h),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 10.h),
                                  decoration: BoxDecoration(
                                    color: whiteCl,
                                    border: Border.all(color: const Color(0xFFDBA195), width: 1),
                                    borderRadius: BorderRadius.circular(7.dm),
                                  ),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        homeWorkIc,
                                        height: 18.h,
                                        width: 18.w,
                                        color: const Color(0xFFA41C00),
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(width: 8.w),
                                      Expanded(
                                        child: Text(
                                          contextCtr.bookingDetailsModel.value.addressDetails!.addressLine1!.toString(),
                                          style: TextStyle(
                                            color: blackCl,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 10.sp,
                                            fontFamily: regular,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 15.w),
                                      Container(
                                        height: 15.h,
                                        width: 15.w,
                                        padding: const EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: mainColor,
                                            width: 1,
                                          ),
                                        ),
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: mainColor,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () {},
                                      child: Container(
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
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )),
                        SizedBox(height: 10.h),
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
                        MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: contextCtr.bookingDetailsModel.value.bookingDetails!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  margin: const EdgeInsets.symmetric(vertical: 5),
                                  padding: EdgeInsets.all(6.h),
                                  decoration: BoxDecoration(
                                    color: whiteCl,
                                    borderRadius: BorderRadius.circular(8.dm),
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
                                            height: 64.h,
                                            width: 64.w,
                                            padding: EdgeInsets.all(5.w),
                                            decoration: BoxDecoration(
                                                color: const Color(0xFFEEFFF2), border: Border.all(color: mainColor.withOpacity(0.23), width: 0.5), borderRadius: BorderRadius.circular(5)),
                                            child: Image.asset(injectionIc),
                                          ),
                                          SizedBox(width: 14.w),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                RichText(
                                                    text: TextSpan(
                                                        text: contextCtr.bookingDetailsModel.value.bookingDetails![index].serviceName.toString(),
                                                        style: TextStyle(
                                                          color: blackCl,
                                                          fontStyle: FontStyle.normal,
                                                          fontSize: 20.sp,
                                                          fontFamily: semiBold,
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                        children: [
                                                      TextSpan(
                                                        text: " ",
                                                        style: TextStyle(
                                                          color: blackCl,
                                                          fontStyle: FontStyle.normal,
                                                          fontSize: 10.sp,
                                                          fontFamily: semiBold,
                                                          fontWeight: FontWeight.w400,
                                                        ),
                                                      )
                                                    ])),
                                                SizedBox(height: 15.h),
                                                Text(
                                                  "₹ ${contextCtr.bookingDetailsModel.value.bookingDetails![index].price.toString()}",
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
                                      ExpandableTextWidget(text: contextCtr.bookingDetailsModel.value.bookingDetails![index].serviceName.toString())
                                    ],
                                  ),
                                );
                              }),
                        ),
                        SizedBox(height: 15.h),
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
                              contextCtr.bookingDetailsModel.value.paymentType == "Cash on Home"
                                  ? Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(color: blackCl, borderRadius: BorderRadius.circular(14)),
                                      child: Text(
                                        "Collect Cash",
                                        style: TextStyle(
                                          color: whiteCl,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 12.sp,
                                          fontFamily: semiBold,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    )
                                  : Container(
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
                        SizedBox(height: 20.h),
                        contextCtr.bookingDetailsModel.value.status == "pending"
                            ? Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          contextCtr.vendorBookingAccept(contextCtr.bookingDetailsModel.value.bookingId.toString(), "0");
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
                                          contextCtr.vendorBookingAccept(contextCtr.bookingDetailsModel.value.bookingId.toString(), "1");
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
                                ),
                              )
                            : Container(
                                height: 44,
                                padding: const EdgeInsets.symmetric(horizontal: 35),
                                child: CustomButtonWidget(
                                  padding: EdgeInsets.zero,
                                  style: CustomButtonStyle.style2,
                                  onPressed: () {
                                    otpDialogShow();
                                  },
                                  text: 'Booking Complete',
                                ),
                              ),
                        SizedBox(height: 20.h),
                      ],
                    );
                  }),
                ),
              ),
            ),
          );
        });
  }

  void otpDialogShow() {
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
                              text: "Please enter the verification code sent to your mobile number ",
                              style: TextStyle(
                                color: greyColorTxt,
                                fontStyle: FontStyle.normal,
                                fontSize: 14.sp,
                                fontFamily: regular,
                                fontWeight: FontWeight.w400,
                              ),
                              children: [
                                TextSpan(
                                  text: "+91 8974784141",
                                  style: TextStyle(
                                    color: blackCl,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 14.sp,
                                    fontFamily: semiBold,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
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
                          /*  controller.otpV = value;
                        Log.console(value);*/
                        },
                      ),
                    ),
                    SizedBox(height: 70.h),
                    SizedBox(
                      height: 44,
                      child: CustomButtonWidget(
                        padding: EdgeInsets.zero,
                        style: CustomButtonStyle.style2,
                        onPressed: () {
                          Get.back();
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
