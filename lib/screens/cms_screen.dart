
import 'package:at_your_home_partner/constants/constants.dart';
import 'package:at_your_home_partner/controller/cms_controller.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CmsScreen extends StatefulWidget {
  final String tittle;

  const CmsScreen({super.key, required this.tittle});

  @override
  State<CmsScreen> createState() => _CmsScreenState();
}

class _CmsScreenState extends State<CmsScreen> {
  CmsController cms = Get.put(CmsController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: Get.find<CmsController>(),
        initState: (state) {
          if (widget.tittle == "Contact Us") {
            Get.find<CmsController>().cmsGet("3");
          }
          if (widget.tittle == "Privacy Policy") {
            Get.find<CmsController>().cmsGet("4");
          }
          if (widget.tittle == "Terms and Conditions") {
            Get.find<CmsController>().cmsGet("2");
          }
          if (widget.tittle == "About Us") {
            Get.find<CmsController>().cmsGet("1");
          }
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
                        widget.tittle,
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
                padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 20.h),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Builder(builder: (context) {
                        if (cms.isLoading) {
                          return  Center(
                            child: SizedBox(
                              height:MediaQuery.of(context).size.height-200,
                              width: 400,
                              child: const Center(
                                child: CircularProgressIndicator(
                                  color: mainColor,
                                ),
                              ),
                            ),
                          );
                        }
                        return Html(
                          data: cms.content.toString(),
                          style: {
                            "body": Style(
                              fontSize: FontSize(14),
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                              fontFamily: regular,
                              color: blackCl,
                            ),
                          },
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
