import 'package:at_your_home_partner/constants/constants.dart';
import 'package:at_your_home_partner/core/common_widgets/custom_buttons.dart';
import 'package:at_your_home_partner/screens/home_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SuccessfullyCompleted extends StatefulWidget {
  const SuccessfullyCompleted({super.key});

  @override
  State<SuccessfullyCompleted> createState() => _SuccessfullyCompletedState();
}

class _SuccessfullyCompletedState extends State<SuccessfullyCompleted> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool willLeave = false;
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HomeScreen()));
        return willLeave;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: whiteCl,
          body: Column(
            children: [
              SizedBox(height: 126.h, width: MediaQuery.of(context).size.width),
              Image.asset(appLogo, height: 82.h, width: 112.w),
              SizedBox(height: 50.h),
              Image.asset(
                ssGif,
                width: 216.w,
                height: 182.h,
              ),
              SizedBox(height: 50.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 60.w),
                child: Text(
                  "Your booking has been successfully completed.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: blackCl,
                    fontStyle: FontStyle.normal,
                    fontSize: 18.sp,
                    fontFamily: semiBold,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 50.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 60.w),
                child: SizedBox(
                  height: 43.h,
                  child: CustomButtonWidget(
                    padding: EdgeInsets.zero,
                    style: CustomButtonStyle.style2,
                    onPressed: () {
                      Get.to(() => const HomeScreen());
                    },
                    text: 'Ok',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
