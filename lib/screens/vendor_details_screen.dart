import 'package:at_your_home_partner/constants/constants.dart';
import 'package:at_your_home_partner/controller/my_service_controller.dart';
import 'package:at_your_home_partner/service/api_logs.dart';
import 'package:at_your_home_partner/service/api_url.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VendorDetailsScreen extends StatefulWidget {
  final String serviceId;
  final String price;
  final String serviceTitle;

  const VendorDetailsScreen({super.key, required this.serviceId, required this.serviceTitle, required this.price});

  @override
  State<VendorDetailsScreen> createState() => _VendorDetailsScreenState();
}

class _VendorDetailsScreenState extends State<VendorDetailsScreen> {
  MyServiceController controller = Get.put(MyServiceController());
  List type = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
@override
  void initState() {
  controller.selectedIndex=0;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: Get.find<MyServiceController>(),
        initState: (state) {
          Get.find<MyServiceController>().serviceDetailsApi(widget.serviceId);
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
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
                child: SingleChildScrollView(
                  child: Builder(builder: (context) {
                    if (contextCtr.isLoading) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height - 200,
                        width: MediaQuery.of(context).size.width,
                        child: const Center(
                            child: CircularProgressIndicator(
                          color: mainColor,
                        )),
                      );
                    }
                    if (contextCtr.serviceDetailsModel == null) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                          ),
                          SizedBox(height: 150.h),
                          Image.asset(
                            noBooking,
                            height: 175.h,
                            width: 188.w,
                          ),
                          SizedBox(height: 80.h),
                          Text(
                            "No Service Details Found",
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
                      );
                    }
                    return Column(
                      children: [
                        SizedBox(width: MediaQuery.of(context).size.width),
                      /*  ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child:
                              *//*contextCtr.serviceDetailsModel.vendorImages != ""
                              ? CachedNetworkImage(
                                  errorWidget: (context, url, error) => Image.asset(drDemoImg, fit: BoxFit.fill, height: 82.h, width: 82.w),
                                  fit: BoxFit.fill,
                                  height:125.h,
                                  width: 125.w,
                                  imageUrl: ApiUrl.imageUrl + contextCtr.vendorDetailsModel.profileImage.toString(),
                                  placeholder: (a, b) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : *//*
                              Image.asset(drDemoImg, height: 116.h, width: 116.w),
                        ),
                        SizedBox(height: 18.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              contextCtr.serviceDetailsModel.vendorId.toString(),
                              style: TextStyle(
                                color: blackCl,
                                fontStyle: FontStyle.normal,
                                fontSize: 18.sp,
                                fontFamily: semiBold,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 4.w),
                          ],
                        ),
                        SizedBox(height: 18.h),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                          decoration: BoxDecoration(color: appBar, borderRadius: BorderRadius.circular(10)),
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              const Icon(
                                Icons.verified,
                                size: 12,
                                color: Colors.yellow,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                "Medical Registration Verified",
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
                        ),
                        SizedBox(height: 20.h),*/
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                          decoration: BoxDecoration(color: const Color(0xFFFFECDB), borderRadius: BorderRadius.circular(7), border: Border.all(color: const Color(0xFFE2C9B3))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: MediaQuery.of(context).size.width),
                              Text(
                                contextCtr.serviceDetailsModel.serviceDetail!.categoryName.toString(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 14.sp,
                                  fontFamily: regular,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Row(
                                children: [
                                  Container(
                                    height: 30.h,
                                    width: 30.w,
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFCA5E00),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Image.asset(
                                      medicalKitIc,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                 Expanded(child:  Text(
                                    "  ${contextCtr.serviceDetailsModel.serviceDetail!.subcategoryName.toString()} (${widget.serviceTitle.toString()})",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 12.sp,
                                      fontFamily: regular,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),)
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 25.h),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Description",
                            style: TextStyle(
                              color: Colors.black,
                              fontStyle: FontStyle.normal,
                              fontSize: 18.sp,
                              fontFamily: regular,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(height: 7.h),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Html(
                            data: contextCtr.serviceDetailsModel.aboutVendor ?? "",
                            style: {
                              "body": Style(
                                fontSize: FontSize(12),
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                                fontFamily: regular,
                                color: blackCl,
                              ),
                            },
                          ),
                        ),
                        SizedBox(height: 16.h),
                        /* Row(
                          children: [
                            Image.asset(
                              clockTime,
                              height: 16.h,
                              width: 16.w,
                              color: mainColor,
                            ),
                            SizedBox(width: 5.w),
                            Text(
                              "Time Slots",
                              style: TextStyle(
                                color: mainColor,
                                fontStyle: FontStyle.normal,
                                fontSize: 12.sp,
                                fontFamily: semiBold,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),*/
                        SizedBox(height: 16.h),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Time Slot by Days ",
                            style: TextStyle(
                              color: Colors.black,
                              fontStyle: FontStyle.normal,
                              fontSize: 18.sp,
                              fontFamily: regular,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Container(
                          height: 40.h,
                          padding: EdgeInsets.only(top: 10.h, right: 5.w, left: 5.w, bottom: 5.h),
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
                                          contextCtr.selectedIndex = index;
                                        });
                                      },
                                      child: Column(
                                        children: [
                                          Text(
                                            type[index],
                                            style: TextStyle(
                                              color: contextCtr.selectedIndex == index ? mainColor : const Color(0xFF807E7E),
                                              fontStyle: FontStyle.normal,
                                              fontSize: 14.sp,
                                              fontFamily: regular,
                                              fontWeight: contextCtr.selectedIndex == index ? FontWeight.w600 : FontWeight.w400,
                                            ),
                                          ),
                                          contextCtr.selectedIndex == index
                                              ? Container(
                                            width: 47.w,
                                            height: 2,
                                            color: mainColor,
                                          )
                                              : SizedBox(width: 47.w)
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              }),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        isSlotEmpty(contextCtr.selectedIndex)
                            ? Column(
                          children: [
                            Text(
                              "Time Slot Not Added on this day.",
                              style: TextStyle(
                                color: blackCl,
                                fontStyle: FontStyle.normal,
                                fontSize: 16.sp,
                                fontFamily: semiBold,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        )
                            : GridView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.only(right: 36.w),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10.0,
                            crossAxisSpacing: 14.0,
                            childAspectRatio: 4,
                          ),
                          itemCount: contextCtr.selectedIndex == 0
                              ? contextCtr.serviceDetailsModel.timeSlots?.sunSlots?.length
                              : contextCtr.selectedIndex == 1
                              ? contextCtr.serviceDetailsModel.timeSlots?.monSlots?.length
                              : contextCtr.selectedIndex == 2
                              ? contextCtr.serviceDetailsModel.timeSlots?.tueSlots?.length
                              : contextCtr.selectedIndex == 3
                              ? contextCtr.serviceDetailsModel.timeSlots?.wedSlots?.length
                              : contextCtr.selectedIndex == 4
                              ? contextCtr.serviceDetailsModel.timeSlots?.thuSlots?.length
                              : contextCtr.selectedIndex == 5
                              ? contextCtr.serviceDetailsModel.timeSlots?.friSlots?.length
                              : contextCtr.serviceDetailsModel.timeSlots?.satSlots?.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 9.h),
                              decoration: BoxDecoration(
                                color: mainColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  contextCtr.selectedIndex == 0
                                      ? contextCtr.serviceDetailsModel.timeSlots!.sunSlots![index].timeslots.toString()
                                      : contextCtr.selectedIndex == 1
                                      ? contextCtr.serviceDetailsModel.timeSlots!.monSlots![index].timeslots.toString()
                                      : contextCtr.selectedIndex == 2
                                      ? contextCtr.serviceDetailsModel.timeSlots!.tueSlots![index].timeslots.toString()
                                      : contextCtr.selectedIndex == 3
                                      ? contextCtr.serviceDetailsModel.timeSlots!.wedSlots![index].timeslots.toString()
                                      : contextCtr.selectedIndex == 0
                                      ? contextCtr.serviceDetailsModel.timeSlots!.thuSlots![index].timeslots.toString()
                                      : contextCtr.selectedIndex == 5
                                      ? contextCtr.serviceDetailsModel.timeSlots!.friSlots![index].timeslots.toString()
                                      : contextCtr.serviceDetailsModel.timeSlots!.satSlots![index].timeslots.toString(),
                                  style: TextStyle(
                                    color: whiteCl,
                                    fontFamily: regular,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 16.h),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Images",
                            style: TextStyle(
                              color: Colors.black,
                              fontStyle: FontStyle.normal,
                              fontSize: 18.sp,
                              fontFamily: regular,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        contextCtr.serviceDetailsModel.vendorImages!.isEmpty
                            //&& contextCtr.vendorDetailsModel.vendorImage!.isEmpty
                            ? Text(
                                "No Images Added ",
                                style: TextStyle(
                                  color: blackCl,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 16.sp,
                                  fontFamily: semiBold,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            : GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: contextCtr.serviceDetailsModel.vendorImages?.length,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 1,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8,
                                  crossAxisCount: 3,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  return index == 5
                                      ? Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(5),
                                              child: Image.asset(
                                                demoPatientImg,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(color: Colors.black.withOpacity(0.60)),
                                              child: Center(
                                                child: Text(
                                                  "View All",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 14.sp,
                                                    fontFamily: regular,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      : ClipRRect(
                                          borderRadius: BorderRadius.circular(5),
                                          child: contextCtr.serviceDetailsModel.vendorImages![index].image != ""
                                              ? CachedNetworkImage(
                                                  errorWidget: (context, url, error) => Image.asset(demoPatientImg, fit: BoxFit.fill, height: 82.h, width: 82.w),
                                                  fit: BoxFit.fill,
                                                  height: 50,
                                                  width: 50,
                                                  imageUrl: ApiUrl.imageUrl + contextCtr.serviceDetailsModel.vendorImages![index].image.toString(),
                                                  placeholder: (a, b) => const Center(
                                                    child: CircularProgressIndicator(),
                                                  ),
                                                )
                                              : Image.asset(
                                                  demoPatientImg,
                                                  height: 50,
                                                  width: 50,
                                                  fit: BoxFit.fill,
                                                ),
                                        );
                                },
                              ),

                        SizedBox(height: 25.h),
                        Visibility(
                          visible: false,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Reviews (262)",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 18.sp,
                                  fontFamily: regular,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "View All",
                                    style: TextStyle(
                                      color: appBar,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 12.sp,
                                      fontFamily: regular,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Visibility(
                          visible: false,
                          child: MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              itemCount: 10,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  margin: EdgeInsets.symmetric(vertical: 5.h),
                                  padding: EdgeInsets.all(10.h),
                                  decoration: BoxDecoration(color: whiteCl, borderRadius: BorderRadius.circular(10.dm), border: Border.all(color: borderColorCont)),
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 35.h,
                                            width: 35.w,
                                            decoration: BoxDecoration(
                                              color: whiteCl,
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: mainColor,
                                                width: 1,
                                              ),
                                            ),
                                            child: Image.asset(
                                              clientDemo,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          SizedBox(width: 8.w),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Rajkumar Sharma",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 14.sp,
                                                    fontFamily: semiBold,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    RatingBar.builder(
                                                      initialRating: double.parse(4.toString()),
                                                      minRating: 1,
                                                      ignoreGestures: true,
                                                      direction: Axis.horizontal,
                                                      allowHalfRating: true,
                                                      itemCount: 5,
                                                      itemSize: 12,
                                                      itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                                                      itemBuilder: (context, _) => Image.asset(
                                                        starActiveIc,
                                                        height: 12,
                                                        width: 12,
                                                        color: appBar,
                                                      ),
                                                      onRatingUpdate: (rating) {
                                                        Log.console(rating);
                                                      },
                                                    ),
                                                    SizedBox(width: 2.w),
                                                    Text(
                                                      "4.5",
                                                      style: TextStyle(
                                                        color: greyColorTxt,
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
                                          Text(
                                            "Today",
                                            style: TextStyle(
                                              color: greyColorTxt,
                                              fontStyle: FontStyle.normal,
                                              fontSize: 12.sp,
                                              fontFamily: regular,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 12.h),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "orem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining... ",
                                          style: TextStyle(
                                            color: blackCl,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 12.sp,
                                            fontFamily: regular,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 80.h)
                      ],
                    );
                  }),
                ),
              ),
            ),
          );
        });
  }

  bool isSlotEmpty(int selectedIndex) {
    final timeSlots = controller.serviceDetailsModel.timeSlots;

    switch (selectedIndex) {
      case 0:
        return timeSlots?.sunSlots?.isEmpty ?? true;
      case 1:
        return timeSlots?.monSlots?.isEmpty ?? true;
      case 2:
        return timeSlots?.tueSlots?.isEmpty ?? true;
      case 3:
        return timeSlots?.wedSlots?.isEmpty ?? true;
      case 4:
        return timeSlots?.thuSlots?.isEmpty ?? true;
      case 5:
        return timeSlots?.friSlots?.isEmpty ?? true;
      case 6:
        return timeSlots?.satSlots?.isEmpty ?? true;
      default:
        return true;
    }
  }
}
