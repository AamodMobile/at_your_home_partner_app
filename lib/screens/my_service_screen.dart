import 'package:at_your_home_partner/constants/constants.dart';
import 'package:at_your_home_partner/controller/my_service_controller.dart';
import 'package:at_your_home_partner/core/common_widgets/custom_buttons.dart';
import 'package:at_your_home_partner/model/my_service_list_model.dart';
import 'package:at_your_home_partner/screens/service_booking_screen.dart';
import 'package:at_your_home_partner/screens/vendor_details_screen.dart';
import 'package:at_your_home_partner/service/api_url.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyServiceScreen extends StatefulWidget {
  const MyServiceScreen({super.key});

  @override
  State<MyServiceScreen> createState() => _MyServiceScreenState();
}

class _MyServiceScreenState extends State<MyServiceScreen> {
  MyServiceController controller = Get.put(MyServiceController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: Get.find<MyServiceController>(),
        initState: (state) {
          Get.find<MyServiceController>().myServiceGet();
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
                      "My Service",
                      style: TextStyle(
                        color: whiteCl,
                        fontStyle: FontStyle.normal,
                        fontSize: 18.sp,
                        fontFamily: semiBold,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
              child: Column(
                children: [
                  Builder(builder: (context) {
                    if (controller.isLoading) {
                      return Center(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height - 200,
                          width: 400,
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: mainColor,
                            ),
                          ),
                        ),
                      );
                    }
                    if (controller.myServiceList.isEmpty) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 150.h,
                            width: MediaQuery.of(context).size.width,
                          ),
                          Image.asset(
                            noBooking,
                            height: 175.h,
                            width: 188.w,
                          ),
                          SizedBox(height: 60.h),
                          Text(
                            "Haven't service yet.",
                            style: TextStyle(
                              color: blackCl,
                              fontStyle: FontStyle.normal,
                              fontSize: 16.sp,
                              fontFamily: semiBold,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 60.h),
                          SizedBox(
                            height: 47.h,
                            width: 175.w,
                            child: CustomButtonWidget(
                              padding: EdgeInsets.zero,
                              style: CustomButtonStyle.style3,
                              onPressed: () {
                                Get.back();
                              },
                              text: 'Go Home',
                            ),
                          ),
                          SizedBox(height: 40.h),
                        ],
                      );
                    }
                    return Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.myServiceList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return myServiceTile(controller.myServiceList[index]);
                        },
                      ),
                    );
                  })
                ],
              ),
            ),
          ));
        });
  }

  Widget myServiceTile(MyServiceListModel model) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7),
      decoration: BoxDecoration(
        color: whiteCl,
        borderRadius: BorderRadius.circular(10.dm),
        border: Border.all(color: const Color(0xFFE4E4E4)),
      ),
      child: Column(
        children: [
          SizedBox(height: 14.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(color: lightFillCl, borderRadius: BorderRadius.circular(5.dm), border: Border.all(color: mainColor.withOpacity(0.23))),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: model.bannerImage != ""
                        ? CachedNetworkImage(
                            errorWidget: (context, url, error) => Image.asset(
                              isolation,
                              fit: BoxFit.fill,
                            ),
                            fit: BoxFit.fill,
                            height: 35.h,
                            width: 35.w,
                            imageUrl: ApiUrl.imageUrl + model.bannerImage.toString(),
                            placeholder: (a, b) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : Image.asset(
                            injectionIc,
                            height: 35.h,
                            width: 35.w,
                            fit: BoxFit.contain,
                          ),
                  ),
                ),
                SizedBox(width: 14.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        model.title.toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontStyle: FontStyle.normal,
                          fontSize: 16.sp,
                          fontFamily: semiBold,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        "₹ ${model.price.toString()}",
                        maxLines: 3,
                        style: TextStyle(
                          color: greyColorTxt,
                          fontStyle: FontStyle.normal,
                          fontSize: 12.sp,
                          fontFamily: regular,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(color: appBar, borderRadius: BorderRadius.circular(4)),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.star,
                        size: 12,
                        color: Colors.yellow,
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Text(
                        model.avgRating.toString(),
                        style: TextStyle(
                          color: whiteCl,
                          fontStyle: FontStyle.normal,
                          fontSize: 12.sp,
                          fontFamily: regular,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 10.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7),
            decoration: const BoxDecoration(
                color: Color(0xFFE0F6E5),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      controller.serviceDeleteApi(model.id.toString());
                    },
                    child: SizedBox(
                      width: 156.w,
                      child: Row(
                        children: [
                          Image.asset(
                            deleteIc,
                            height: 16.h,
                            width: 16.w,
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            "Remove",
                            style: TextStyle(
                              color: redColor,
                              fontStyle: FontStyle.normal,
                              fontSize: 10.sp,
                              fontFamily: semiBold,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 5.w),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => VendorDetailsScreen(serviceId: model.id.toString(), serviceTitle: model.title.toString(), price: model.price.toString()));
                    },
                    child: Container(
                      width: 156.w,
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(26),
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromRGBO(96, 175, 114, 1),
                            Color.fromRGBO(38, 103, 52, 1),
                          ],
                        ),
                        border: Border.all(color: mainColor),
                      ),
                      child: Text(
                        "View Details",
                        style: TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.normal,
                          fontSize: 13.sp,
                          fontFamily: semiBold,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 15.w),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => ServiceBookingScreen(serviceId: model.id.toString(), serviceTitle: model.title.toString(), price: model.price.toString()));
                    },
                    child: Container(
                      width: 156.w,
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(26),
                        color: Colors.white,
                        border: Border.all(color: mainColor),
                      ),
                      child: Text(
                        "My Booking",
                        style: TextStyle(
                          color: mainColor,
                          fontStyle: FontStyle.normal,
                          fontSize: 13.sp,
                          fontFamily: semiBold,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
