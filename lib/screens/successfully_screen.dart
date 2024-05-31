
import 'package:at_your_home_partner/constants/constants.dart';
import 'package:at_your_home_partner/core/common_widgets/custom_buttons.dart';
import 'package:at_your_home_partner/model/user_model.dart';
import 'package:at_your_home_partner/screens/home_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SuccessfullyScreen extends StatefulWidget {
  final String type;
  final String userName;
  final UserData user;
  const SuccessfullyScreen({super.key, required this.type, required this.userName, required this.user});

  @override
  State<SuccessfullyScreen> createState() => _SuccessfullyScreenState();
}

class _SuccessfullyScreenState extends State<SuccessfullyScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage(successfullyBg),
            fit: BoxFit.fill,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                SizedBox(width: MediaQuery.of(context).size.width,),
              Image.asset(ssGif,width: 216.w,height: 182.h,),
              SizedBox(height:73.h,),
              Text(
                "Successfully ",
                style: TextStyle(
                  color: Colors.black,
                  fontStyle: FontStyle.normal,
                  fontSize: 20.sp,
                  fontFamily: semiBold,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height:14.h),
              Text(
               widget.type,
                style: TextStyle(
                  color: greyColorTxt,
                  fontStyle: FontStyle.normal,
                  fontSize: 14.sp,
                  fontFamily: regular,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height:60.h),
              Container(
                height: 44,
                padding: const EdgeInsets.symmetric(horizontal: 70),
                child: CustomButtonWidget(
                  padding: EdgeInsets.zero,
                  style: CustomButtonStyle.style2,
                  onPressed: () {
                    Get.to(()=>const HomeScreen());
                  },
                  text: 'Ok',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
