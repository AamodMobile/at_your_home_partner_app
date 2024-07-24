import 'package:at_your_home_partner/constants/constants.dart';
import 'package:at_your_home_partner/controller/my_feedback_controller.dart';
import 'package:at_your_home_partner/core/common_widgets/custom_buttons.dart';
import 'package:at_your_home_partner/service/api_logs.dart';
import 'package:at_your_home_partner/service/api_url.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  MyFeedbackController controller = Get.put(MyFeedbackController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<MyFeedbackController>(),
      initState: (state) {
        Get.find<MyFeedbackController>().myFeedbackGet();
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
                      "Feedbacks",
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
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: Column(
                children: [
                  SizedBox(height: 12.h),
                  Builder(
                    builder: (context) {
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
                      if (controller.myFeedbackList.isEmpty) {
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
                              "Haven't feedback yet.",
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
                          itemCount: contextCtr.myFeedbackList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 5.h),
                              padding: EdgeInsets.all(10.h),
                              decoration: BoxDecoration(color: whiteCl, borderRadius: BorderRadius.circular(10.dm), border: Border.all(color: borderColorCont)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(20.dm),
                                          child: contextCtr.myFeedbackList[index].userData!.profilePic != ""
                                              ? CachedNetworkImage(
                                                  errorWidget: (context, url, error) => Image.asset(drDemoImg, fit: BoxFit.fill, height: 82.h, width: 82.w),
                                                  fit: BoxFit.fill,
                                                  height: 35.h,
                                                  width: 35.w,
                                                  imageUrl: ApiUrl.imageUrl + contextCtr.myFeedbackList[index].userData!.profilePic.toString(),
                                                  placeholder: (a, b) => const Center(
                                                    child: CircularProgressIndicator(),
                                                  ),
                                                )
                                              : Image.asset(
                                                  clientDemo,
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                      ),
                                      SizedBox(width: 8.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              contextCtr.myFeedbackList[index].userData!.name.toString(),
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
                                                  contextCtr.myFeedbackList[index].rating.toString(),
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
                                        formatDate(contextCtr.myFeedbackList[index].createdAt.toString()),
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
                                      contextCtr.myFeedbackList[index].title.toString(),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 14.sp,
                                        fontFamily: bold,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      contextCtr.myFeedbackList[index].description.toString(),
                                      style: TextStyle(
                                        color: blackCl,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 12.sp,
                                        fontFamily: regular,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 12.h),
                                  MediaQuery.removePadding(
                                    removeTop: true,
                                    context: context,
                                    child: ListView.builder(
                                      physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: contextCtr.myFeedbackList[index].serviceDetails?.length,
                                      itemBuilder: (BuildContext context, int ind) {
                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Service : ${contextCtr.myFeedbackList[index].serviceDetails![ind].title.toString()}",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 12.sp,
                                                fontFamily: semiBold,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(height: 5.h)
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String formatDate(String date) {
    try {
      DateTime parsedDate = DateTime.parse(date);
      String formattedDate = DateFormat("dd-MM-yyyy").format(parsedDate);
      return formattedDate;
    } catch (e) {
      return "N/A";
    }
  }
}
