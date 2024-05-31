
import 'package:at_your_home_partner/constants/constants.dart';
import 'package:at_your_home_partner/controller/notification_controller.dart';
import 'package:at_your_home_partner/core/common_widgets/custom_buttons.dart';
import 'package:at_your_home_partner/model/notification_list_model.dart';
import 'package:at_your_home_partner/service/api_url.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationController controller = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<NotificationController>(),
      initState: (state) {
        Get.find<NotificationController>().notificationsGet();
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
                      "Notification",
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
            body: Column(
              children: [
                SizedBox(height: 10.h),
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
                  if (controller.notificationList.isEmpty) {
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
                          "Haven't notification yet.",
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
                            onPressed: () {},
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
                      itemCount: controller.notificationList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return notificationTile(controller.notificationList[index]);
                      },
                    ),
                  );
                })
              ],
            ),
          ),
        );
      },
    );
  }

  Widget notificationTile(NotificationListModel model) {
    return Container(
      padding: EdgeInsets.all(9.h),
      margin: EdgeInsets.symmetric(horizontal: 17.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: whiteCl,
        borderRadius: BorderRadius.circular(9.dm),
        border: Border.all(
          color: const Color(0xFFE4E4E4),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          model.image == ""
              ? const SizedBox()
              : Container(
                  height: 80.h,
                  width: 80.w,
                  padding: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: model.image != ""
                        ? CachedNetworkImage(
                            errorWidget: (context, url, error) => Image.asset(
                              isolation,
                              fit: BoxFit.fill,
                            ),
                            fit: BoxFit.fill,
                      height: 80.h,
                      width: 80.w,
                            imageUrl: ApiUrl.imageUrl + model.image.toString(),
                            placeholder: (a, b) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : Image.asset(
                            isolation,
                            height: 80.h,
                            width: 80.w,
                            fit: BoxFit.contain,
                          ),
                  ),
                ),
          SizedBox(width: 12.w),
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
                  model.description.toString(),
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
          )
        ],
      ),
    );
  }
}
