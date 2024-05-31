import 'package:at_your_home_partner/constants/constants.dart';
import 'package:at_your_home_partner/screens/add_bank_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyIncomeScreen extends StatefulWidget {
  const MyIncomeScreen({super.key});

  @override
  State<MyIncomeScreen> createState() => _MyIncomeScreenState();
}

class _MyIncomeScreenState extends State<MyIncomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
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
                  "My Income",
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 230.h,
              padding: EdgeInsets.symmetric(vertical: 10.h),
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(color: Color(0xFFE5F6E9)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = 0;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 27.w),
                          decoration: BoxDecoration(
                              color: whiteCl,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: selectedIndex == 0 ? Colors.transparent : appBar, width: 1),
                              gradient: selectedIndex == 0
                                  ? const LinearGradient(
                                      colors: [
                                        Color(0xFFFFB185),
                                        Color(0xFFD94100),
                                      ],
                                    )
                                  : null),
                          child: Text(
                            "Day",
                            style: TextStyle(
                              color: selectedIndex == 0 ? Colors.white : appBar,
                              fontStyle: FontStyle.normal,
                              fontSize: 14.sp,
                              fontFamily: semiBold,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 6.w),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = 1;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 27.w),
                          decoration: BoxDecoration(
                              color: whiteCl,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: selectedIndex == 1 ? Colors.transparent : appBar, width: 1),
                              gradient: selectedIndex == 1
                                  ? const LinearGradient(
                                      colors: [
                                        Color(0xFFFFB185),
                                        Color(0xFFD94100),
                                      ],
                                    )
                                  : null),
                          child: Text(
                            "Week",
                            style: TextStyle(
                              color: selectedIndex == 1 ? Colors.white : appBar,
                              fontStyle: FontStyle.normal,
                              fontSize: 14.sp,
                              fontFamily: semiBold,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 6.w),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = 2;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 27.w),
                          decoration: BoxDecoration(
                              color: whiteCl,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: selectedIndex == 2 ? Colors.transparent : appBar, width: 1),
                              gradient: selectedIndex == 2
                                  ? const LinearGradient(
                                      colors: [
                                        Color(0xFFFFB185),
                                        Color(0xFFD94100),
                                      ],
                                    )
                                  : null),
                          child: Text(
                            "Month",
                            style: TextStyle(
                              color: selectedIndex == 2 ? Colors.white : appBar,
                              fontStyle: FontStyle.normal,
                              fontSize: 14.sp,
                              fontFamily: semiBold,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      SizedBox(width: 36.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                              decoration: const BoxDecoration(
                                  color: Color(0xFFFFC8AE),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(4),
                                    bottomRight: Radius.circular(4),
                                  )),
                              child: Text(
                                "03-May-2024",
                                style: TextStyle(
                                  color: const Color(0xFF9C3102),
                                  fontStyle: FontStyle.normal,
                                  fontSize: 10.sp,
                                  fontFamily: semiBold,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            SizedBox(height: 14.h),
                            Text(
                              "Day Income",
                              style: TextStyle(
                                color: blackCl,
                                fontStyle: FontStyle.normal,
                                fontSize: 12.sp,
                                fontFamily: semiBold,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              "₹ 1000",
                              style: TextStyle(
                                color: blackCl,
                                fontStyle: FontStyle.normal,
                                fontSize: 20.sp,
                                fontFamily: semiBold,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 5.h),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: const BoxDecoration(
                                color: whiteCl,
                              ),
                              child: Text(
                                "Total Month ₹ 12000",
                                style: TextStyle(
                                  color: const Color(0xFF807E7E),
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
                      SizedBox(width: 60.w),
                      Container(
                        height: 110.h,
                        width: 175.w,
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), image: const DecorationImage(image: AssetImage(bgAc), fit: BoxFit.cover)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Account Number",
                              style: TextStyle(
                                color: const Color(0xFF807E7E),
                                fontStyle: FontStyle.normal,
                                fontSize: 12.sp,
                                fontFamily: semiBold,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 5.h),
                            Text(
                              "0000000000",
                              style: TextStyle(
                                color: blackCl,
                                fontStyle: FontStyle.normal,
                                fontSize: 12.sp,
                                fontFamily: semiBold,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            GestureDetector(
                              onTap: () {
                                Get.to(()=>const AddBankScreen());
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 25.w),
                                decoration: BoxDecoration(
                                  color: whiteCl,
                                  borderRadius: BorderRadius.circular(5),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFFFFEAB2),
                                      Color(0xFFFFD02C),
                                    ],
                                  ),
                                ),
                                child: Text(
                                  "Edit Bank",
                                  style: TextStyle(
                                    color: blackCl,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 14.sp,
                                    fontFamily: semiBold,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                "All Transactions",
                style: TextStyle(
                  color: blackCl,
                  fontStyle: FontStyle.normal,
                  fontSize: 14.sp,
                  fontFamily: semiBold,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Visibility(
              visible: false,
              child: Expanded(
                child: SizedBox(
                  child: Center(
                    child: Image.asset(
                      noIncome,
                      height: 140.h,
                      width: 160.w,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.w,vertical: 10.h),
                    padding: EdgeInsets.symmetric(vertical: 10.w),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10.dm),
                      border: Border.all(color: borderColorCont, width: 1),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Injection IM",
                                style: TextStyle(
                                  color: blackCl,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 14.sp,
                                  fontFamily: semiBold,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                                decoration: BoxDecoration(color: lightFillCl, borderRadius: BorderRadius.circular(4)),
                                child: Text(
                                  "Online Pay",
                                  style: TextStyle(
                                    color: appBar,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 10.sp,
                                    fontFamily: semiBold,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "₹ 299",
                                style: TextStyle(
                                  color: blackCl,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 12.sp,
                                  fontFamily: semiBold,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                "Tr. ID. 12012121",
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
                        ),
                        SizedBox(height: 10.h),
                        const Divider(color: borderColorCont),
                        SizedBox(height: 10.h),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
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
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}
